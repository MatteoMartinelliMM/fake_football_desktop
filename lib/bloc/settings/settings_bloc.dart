// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fake_football_desktop/bloc/settings/settings_event.dart';
import 'package:fake_football_desktop/bloc/settings/settings_state.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsBloc extends Bloc<PathManagerEvent, SettingsState> {
  late Map<String, dynamic> paths;

  SettingsBloc() : super(LoadState()) {
    on<EnterPageEvent>(_mapOnEnterPageEvent);
    on<SettingSelectedEvent>(_mapOnSettingSelectedEvent);
    on<PickPathEvent>(_mapOnPickPathEvent);
    on<BackPressEvent>(_mapOnBackPressEvent);
  }

  Future<FutureOr<void>> _mapOnEnterPageEvent(
      EnterPageEvent event, Emitter<SettingsState> emit) async {
    paths = PathProvider.getPathInfos();
      emit(PathLoadedState(paths));
  }

  Future<FutureOr<void>> _mapOnSettingSelectedEvent(
      SettingSelectedEvent event, Emitter<SettingsState> emit) async {
    FileType? fType = PathProvider.getFileType(event.contentKey);
    if (fType != null) {
      switch (fType) {
        case FileType.any:
        case FileType.media:
        case FileType.image:
        case FileType.video:
        case FileType.audio:
          emit(PickFileState(event.contentKey, fType, PathProvider.getCompletePath([])));
          break;
        case FileType.custom:
          emit(PickExeState(event.contentKey));
          break;
        default:
          emit(PickFileState(event.contentKey, FileType.any, PathProvider.getCompletePath([])));
          break;
      }
    } else
      emit(PickDirectoryState(event.contentKey, PathProvider.getCompletePath([])));
  }

  Future<FutureOr<void>> _mapOnPickPathEvent(
      PickPathEvent event, Emitter<SettingsState> emit) async {
    if (!event.path.isNullOrEmpty()) {
      bool res = await PathProvider.saveSetting(event.contentKey, event.path!);
      if (res) paths[event.contentKey] = event.path;
      print('result of saving ${event.contentKey} $res');
    }
    emit(PathLoadedState(paths));
  }

  FutureOr<void> _mapOnBackPressEvent(BackPressEvent event, Emitter<SettingsState> emit) {}
}
