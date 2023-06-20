import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fake_football_desktop/bloc/home/home_event.dart';
import 'package:fake_football_desktop/bloc/home/home_state.dart';
import 'package:fake_football_desktop/screen/roaster_widget.dart';
import 'package:fake_football_desktop/screen/video_generator_widget.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:fake_football_desktop/screen/build_content_widget.dart';
import 'package:fake_football_desktop/screen/settings_widget.dart';
import 'package:fake_football_desktop/screen/team_making_widget.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository homeRepository;
  final Map<String, String> _currentActionsByLabel = {};
  final Map<String, String> _defaultActionsByLabel = {};
  bool _havePermissions = true;

  HomeBloc({required this.homeRepository}) : super(LoadingHomeState()) {
    on<EnterHomeEvent>(_mapOnEnterHomeEvent);
    on<OverflowMenuEvent>(_mapOnOverflowMenuEvent);
    on<ActionPressedEvent>(_mapOnActionPressedEvent);
    on<RefreshEvent>(_mapOnRefreshEvent);
  }

  Future<FutureOr<void>> _mapOnOverflowMenuEvent(
      OverflowMenuEvent event, Emitter<HomeState> emit) async {
    switch (event.action) {
      case EXPORT_DB:
        if (_havePermissions) {
          await homeRepository.exportDb();
          emit(ShowSnackbarState('Tracking db esportato correttamente.'));
        }
        break;
      case SETTINGS:
        emit(ChangeRouteState(SettingsWidget.route));
        break;
    }
  }

  Future<FutureOr<void>> _mapOnRefreshEvent(RefreshEvent event, Emitter<HomeState> emit) async {
    add(EnterHomeEvent());
  }

  Future<FutureOr<void>> _mapOnActionPressedEvent(
      ActionPressedEvent event, Emitter<HomeState> emit) async {
    emit(ChangeRouteState(event.action));
  }

  Future<FutureOr<void>> _mapOnEnterHomeEvent(EnterHomeEvent event, Emitter<HomeState> emit) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      Map<Permission, PermissionStatus> statuses =
          await (androidInfo.version.sdkInt <= 32 ? STORAGE_PERMISSIONS : STORAGE_33_PERMISIONS)
              .request();
      _havePermissions =
          statuses.values.where((p) => p.isGranted).toList().length == STORAGE_PERMISSIONS.length;
    }
    if (PathProvider.pathThreeInitialized()) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      bool haveGameToClip = await homeRepository.haveGameToClip();
      if (Platform.isWindows && !haveGameToClip) {
        _defaultActionsByLabel[VIDEO_GENERATOR] = VideoGeneratorWidget.route;
      }
      if (connectivityResult != ConnectivityResult.none) {
        _defaultActionsByLabel[ROASTER] = RoasterWidget.route;
        String currentStatus = await homeRepository.checkStatus();
        _currentActionsByLabel.clear();
        switch (currentStatus) {
          case CONVOCA_GIOCATORI:
            _currentActionsByLabel[CONVOCA_GIOCATORI] = TeamMakingWidget.route;
            break;
          case CONFERMA_CONVOCATI:
            _currentActionsByLabel[GEN_OBS] = BuildContentWidget.route;
            _currentActionsByLabel[REDO_P] = TeamMakingWidget.route;
            break;
          case ALL_DONE:
            _currentActionsByLabel[REDO_P] = TeamMakingWidget.route;
          default:
            break;
        }
      }
      emit(MenuLoadedState(_currentActionsByLabel, _defaultActionsByLabel));
    } else {
      emit(ChangeRouteState(SettingsWidget.route));
    }
  }

  String _getRouteByAction(String action) {
    switch (action) {
      case CONVOCA_GIOCATORI:
        return TeamMakingWidget.route;
      case CONFERMA_CONVOCATI:
        return BuildContentWidget.route;
      default:
        return 'Pippiripuppa';
    }
  }
}
