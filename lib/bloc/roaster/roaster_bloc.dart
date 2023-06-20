// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:fake_football_desktop/bloc/roaster/roaster_event.dart';
import 'package:fake_football_desktop/bloc/roaster/roaster_state.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/repository/player_repository.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoasterBloc extends Bloc<RiepilogoGiocatoriEvent, RoasterState> {
  late List<Player> _allPlayers, _allRookies;
  Player? _addedRookie;
  late int _lastIndexUsed, _maxRolesLength;
  String? _errorName;
  PlayerRepository playerRepository;

  RoasterBloc({required this.playerRepository}) : super(LoadingState()) {
    on<EnterOnPageEvent>(_mapOnEnterOnPageEvent);
    on<BackPressEvent>(_mapOnBackPressEvent);
    on<PlayerPickedEvent>(_mapOnPlayerPickedEvent);
    on<ChangeJerseyEvent>(_mapOnChangeJerseyEvent);
    on<OverflowMenuEvent>(_mapOnOverflowMenuEvent);
    on<PlayerNameSubmittedEvent>(_mapOnPlayerNameSubmittedEvent);
    on<NameTypingEvent>(_mapOnNameTypingEvent);
    on<RolePickedEvent>(_mapOnRolePickedEvent);
    on<PlayerConfirmedEvent>(_mapOnPlayerConfirmedEvent);
  }

  FutureOr<void> _mapOnEnterOnPageEvent(EnterOnPageEvent event, Emitter<RoasterState> emit) async {
    _allPlayers = await playerRepository.getPlayersList();
    emit(PlayersLoadedState(_allPlayers));
  }

  FutureOr<void> _mapOnBackPressEvent(BackPressEvent event, Emitter<RoasterState> emit) async {
    emit(state is LoadingState || state is PlayersLoadedState
        ? CloseState()
        : PlayersLoadedState(_allPlayers));
  }

  FutureOr<void> _mapOnChangeJerseyEvent(
      ChangeJerseyEvent event, Emitter<RoasterState> emit) async {
    event.page == 0 ? _allPlayers.marskAsYellowTeam() : _allPlayers.marskAsGreenTeam();
    emit(PlayersLoadedState(_allPlayers));
  }

  FutureOr<void> _mapOnPlayerPickedEvent(
      PlayerPickedEvent event, Emitter<RoasterState> emit) async {
    emit(RiepilogoSinglePlayerState(_allPlayers[event.position]));
  }

  FutureOr<void> _mapOnOverflowMenuEvent(
      OverflowMenuEvent event, Emitter<RoasterState> emit) async {
    emit(LoadingState());
    Map<int, List<Player>> allRookiesAndIndex = await playerRepository.getAllRookiesAndIndex();
    _maxRolesLength = PathProvider.maxRolePerPlayer();
    _lastIndexUsed = allRookiesAndIndex.keys.toList().first;
    _allRookies = allRookiesAndIndex[_lastIndexUsed]!;
    _addedRookie = Player.createRookie('', '');
    emit(CreatePlayerState(
        _addedRookie!,
        _addedRookie!.roles.length < _maxRolesLength
            ? _addedRookie!.roles.length + 1
            : _maxRolesLength));
  }

  Future<FutureOr<void>> _mapOnRolePickedEvent(
      RolePickedEvent event, Emitter<RoasterState> emit) async {
    if (!event.role.isNullOrEmpty() && _addedRookie!.roles.length < _maxRolesLength) {
      _addedRookie!.roles.add(event.role!);
    } else if (event.role.isNullOrEmpty() && _addedRookie!.roles.length > event.affinity)
      _addedRookie!.roles.removeAt(event.affinity);
    emit(CreatePlayerState(
        _addedRookie!,
        _addedRookie!.roles.length < _maxRolesLength
            ? _addedRookie!.roles.length + 1
            : _maxRolesLength));
  }

  Future<FutureOr<void>> _mapOnNameTypingEvent(
      NameTypingEvent event, Emitter<RoasterState> emit) async {
    if (state is RookieAlreadyExistState &&
        !_errorName.isNullOrEmpty() &&
        event.value != _errorName!)
      emit(CreatePlayerState(
          _addedRookie!,
          _addedRookie!.roles.length < _maxRolesLength
              ? _addedRookie!.roles.length + 1
              : _maxRolesLength));
  }

  Future<FutureOr<void>> _mapOnPlayerNameSubmittedEvent(
      PlayerNameSubmittedEvent event, Emitter<RoasterState> emit) async {
    if (_allRookies.firstOrNullWhere((p) => p.name.toLowerCase() == event.name.toLowerCase()) ==
        null) {
      _addedRookie!.name = event.name.toLowerCase();
    } else {
      _errorName = event.name;
      emit(RookieAlreadyExistState(
          _addedRookie!,
          _addedRookie!.roles.length < _maxRolesLength
              ? _addedRookie!.roles.length + 1
              : _maxRolesLength));
    }
  }

  Future<FutureOr<void>> _mapOnPlayerConfirmedEvent(
      PlayerConfirmedEvent event, Emitter<RoasterState> emit) async {
    _lastIndexUsed++;
    String playerId = '$_lastIndexUsed\_${_addedRookie!.name.toLowerCase()}';
    _addedRookie!.playerId = playerId;

    await playerRepository.insertRookie(_addedRookie!, _lastIndexUsed);
    emit(PlayersLoadedState(_allPlayers));
  }
}
