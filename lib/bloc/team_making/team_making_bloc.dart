// ignore_for_file: curly_braces_in_flow_control_structures, avoid_function_literals_in_foreach_calls

import 'dart:io' show Platform;
import 'dart:math';

import 'package:fake_football_desktop/bloc/team_making/team_making_event.dart';
import 'package:fake_football_desktop/bloc/team_making/team_making_state.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/repository/player_repository.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamMakingBloc extends Bloc<TeamMakingEvent, TeamMakingState> {
  PlayerRepository playerRepository;
  List<Player> allPlayers = [];
  List<Player> allRookies = [];
  List<Player> gialliRandom = [];
  List<Player> verdiRandom = [];
  Map<int, Player> gialliByNumbers = {}, verdiByNumbers = {};
  int _playerAmount = 7, _currentTab = 0;

  TeamMakingBloc({required this.playerRepository}) : super(LoadingPlayersState()) {
    on<LoadPlayersEvent>(_mapOnLoadPlayerEvent);
    on<PlayerPickedEvent>(_mapOnPlayerPickedEvent);
    on<RiepilogoPresentiEvent>(_mapOnRiepilogoPresentiEvent);
    on<TeamConfifermedEvent>(_mapOnTeamConfirmedEvent);
    on<ChooseRookieNumber>(_mapOnChooseRookieNumber);
    on<SoccerModeChangeEvent>(_mapSoccerModeChangeEvent);
    on<TeamMakingShuffleEvent>(_mapTeamMakingShuffleEvent);
    on<TeamMakingDisposeEvent>(_mapDisposeEvent);
    on<TabChangeEvent>(_mapTabChangeEvent);
  }

  void _mapSoccerModeChangeEvent(SoccerModeChangeEvent event, Emitter<TeamMakingState> emit) async {
    clearListsAndMap();
    _playerAmount = event.value == CALCIO_7 ? 7 : 5;

    emit(
      PlayersLoadedState()
        ..currentTab = _currentTab
        ..players = allPlayers
        ..rookies = allRookies
        ..gialli = gialliByNumbers
        ..verdi = verdiByNumbers,
    );
  }

  void clearListsAndMap() {
    gialliByNumbers.clear();
    verdiByNumbers.clear();
    resetRandom();
  }

  void _mapOnLoadPlayerEvent(LoadPlayersEvent event, Emitter<TeamMakingState> emit) async {
    if (allPlayers.isEmpty) allPlayers = (await playerRepository.getPlayersList());
    if (allRookies.isEmpty) allRookies = (await playerRepository.getRookiesList());
    emit(PlayersLoadedState()
      ..currentTab = _currentTab
      ..players = allPlayers
      ..rookies = allRookies
      ..gialli = gialliByNumbers
      ..verdi = verdiByNumbers);
  }

  void _mapOnPlayerPickedEvent(PlayerPickedEvent event, Emitter<TeamMakingState> emit) {
    Player p = event.playerPicked;
    p.isYellow = event.isYellow;
    resetRandom();
    print('player picked ${p.number} - ${p.name} in ${p.isYellow ? 'YELLOW' : 'GREEN'} TEAM');
    if (event.isYellow) {
      event.checked ? gialliByNumbers[p.number] = p : gialliByNumbers.remove(p.number);
      if (gialliByNumbers.length == _playerAmount) _currentTab = 1;
    } else {
      event.checked ? verdiByNumbers[p.number] = p : verdiByNumbers.remove(p.number);
      if (verdiByNumbers.length == _playerAmount) _currentTab = 0;
    }
    print("========================== YELLOW MAP ===========================");
    print(gialliByNumbers.printMap());
    print("==========================  GREEN MAP ===========================");
    print(verdiByNumbers.printMap());

    _emitStateDependsOnTeamFulled(emit);
  }

  void resetRandom() {
    gialliRandom.clear();
    verdiRandom.clear();
  }

  void _emitStateDependsOnTeamFulled(Emitter<TeamMakingState> emit) {
    if (gialliByNumbers.length < _playerAmount || verdiByNumbers.length < _playerAmount) {

      emit(PlayersLoadedState()
        ..currentTab = _currentTab
        ..players = allPlayers
        ..rookies = allRookies
        ..gialli = gialliByNumbers
        ..verdi = verdiByNumbers);
    } else {
      emit(TeamsFulledState()
        ..currentTab = _currentTab
        ..players = allPlayers
        ..rookies = allRookies
        ..gialli = gialliByNumbers
        ..verdi = verdiByNumbers);
    }
  }

  void _mapOnChooseRookieNumber(ChooseRookieNumber event, Emitter<TeamMakingState> emit) async {
    print('ChooseRookieNumber');
    String num = event.number ?? NON_CONVOCATO;
    bool isYellow = event.isYellow;
    if (event.number != NON_CONVOCATO) {
      Player p = allRookies.firstOrNullWhere((p) => p == event.p)!;
      int number = int.parse(num);
      p.number = number;
      isYellow ? gialliByNumbers[number] = p : verdiByNumbers[number] = p;
    } else {
      isYellow
          ? gialliByNumbers.removeWhere((key, value) => value == event.p)
          : verdiByNumbers.removeWhere((key, value) => value == event.p);
    }
    _emitStateDependsOnTeamFulled(emit);
  }

  void _mapOnRiepilogoPresentiEvent(
      RiepilogoPresentiEvent event, Emitter<TeamMakingState> emit) async {
    String whatsappMsg = SQUAD_CONFERMATI_HEADER;
    List<Player> players = gialliByNumbers.values.toList()
      ..sort((p1, p2) => p1.number.compareTo(p2.number))
      ..addAll(verdiByNumbers.values.toList()..sort((p1, p2) => p1.number.compareTo(p2.number)));
    List<Player> rookiesAndKeepers = players
        .where((element) =>
            element.number == YELLOW_KEEPER ||
            element.number == GREEN_KEEPER ||
            YELLOW_ROOKIES.contains(element.number) ||
            GREEN_ROOKIES.contains(element.number))
        .toList();
    players.removeWhere((p) => rookiesAndKeepers.contains(p));
    players.forEach((element) => whatsappMsg += "${element.distinta}\n");
    if (rookiesAndKeepers.isNotEmpty) {
      whatsappMsg += ROOKIE_CONFERMATI_HEADER;
      rookiesAndKeepers.forEach((element) => whatsappMsg += "${element.distinta}\n");
    }
    await Clipboard.setData(ClipboardData(text: whatsappMsg));
    emit(RiepilogoCopiedState('Riepilogo giocatori copiato'));
  }

  void _mapOnTeamConfirmedEvent(TeamConfifermedEvent event, Emitter<TeamMakingState> emit) async {
    List<Player> gialli = gialliByNumbers.values.toList()
      ..sort((p1, p2) => p1.number.compareTo(p2.number));
    List<Player> verdi = verdiByNumbers.values.toList()
      ..sort((p1, p2) => p1.number.compareTo(p2.number));
    playerRepository.saveConvocati(gialli, verdi, _playerAmount);
    String whatsappMsg = Y_LINEUP_HEADER;
    gialli.forEach((element) => whatsappMsg += "${element.distinta}\n");
    whatsappMsg += G_LINEUP_HEADER;
    verdi.forEach((element) => whatsappMsg += "${element.distinta}\n");
    await Clipboard.setData(ClipboardData(text: whatsappMsg));
    emit(ThingsDoneState('Squadre create con successo'));
  }

  void _mapDisposeEvent(TeamMakingDisposeEvent event, Emitter<TeamMakingState> emit) async {
    gialliByNumbers = {};
    verdiByNumbers = {};
    allPlayers = [];
    allRookies = [];
  }

  void _mapTeamMakingShuffleEvent(
      TeamMakingShuffleEvent event, Emitter<TeamMakingState> emit) async {
    List<Player> players = gialliByNumbers.values.toList()..shuffle(Random(100));
    players.addAll(verdiByNumbers.values.toList()..shuffle(Random(44)));
    players.shuffle(Random(88));

    List<int> usedShirt = [];
    for (int i = 0; i < players.length; i++) {
      Player currP = players[i];
      if (gialliRandom.length < _playerAmount) {
        if (currP.isRookie && !currP.isYellow) {
          for (int j = 0; j < YELLOW_ROOKIES.length; j++) {
            if (currP.number.getTaglia() == YELLOW_ROOKIES[j].getTaglia() &&
                !usedShirt.contains(YELLOW_ROOKIES[j])) {
              usedShirt.add(YELLOW_ROOKIES[j]);
              currP.number = YELLOW_ROOKIES[j];
              currP.isYellow = true;
              break;
            }
          }
        }
        gialliRandom.add(currP);
      } else {
        if (currP.isRookie && currP.isYellow) {
          for (int j = 0; j < GREEN_ROOKIES.length; j++) {
            if (currP.number.getTaglia() == GREEN_ROOKIES[j].getTaglia() &&
                !usedShirt.contains(GREEN_ROOKIES[j])) {
              usedShirt.add(GREEN_ROOKIES[j]);
              currP.number = GREEN_ROOKIES[j];
              currP.isYellow = false;
              break;
            }
          }
        }
        verdiRandom.add(currP);
      }
    }
    String whatsappMsg = Y_LINEUP_HEADER;
    gialliRandom.sortByNumber();
    verdiRandom.sortByNumber();
    gialliRandom.forEach((element) => whatsappMsg += "${element.distinta}\n");
    whatsappMsg += G_LINEUP_HEADER;
    verdiRandom.forEach((element) => whatsappMsg += "${element.distinta}\n");
    await Clipboard.setData(ClipboardData(text: whatsappMsg));
    emit(RiepilogoCopiedState('Squadre generate casualmente!'));
  }

  void _mapTabChangeEvent(TabChangeEvent event, Emitter<TeamMakingState> emit) async {
    if (event.tab != _currentTab) {
      _currentTab = event.tab;
      _emitStateDependsOnTeamFulled(emit);
    }
  }

  int howManyRookies({bool isYellow = true}) {
    return 1 + (isYellow ? YELLOW_ROOKIES.length : GREEN_ROOKIES.length); //one for the keeper
  }

  int nrRookie({required bool isYellow, required int index}) => isYellow
      ? (index != YELLOW_ROOKIES.length ? YELLOW_ROOKIES[index] : YELLOW_KEEPER)
      : (index != GREEN_ROOKIES.length ? GREEN_ROOKIES[index] : GREEN_KEEPER);

  String teamAmount(List<Player> players, {bool isYellow = true}) => isYellow
      ? "TEAM (${gialliByNumbers.keys.length}/$_playerAmount)"
      : "TEAM (${verdiByNumbers.keys.length}/$_playerAmount)";

  String rookiesAmount(List<Player> players, {bool isYellow = true}) {
    int rookiesAmount = isYellow
        ? gialliByNumbers.values.toList().countWhere((p) => p.isRookie)
        : verdiByNumbers.values.toList().countWhere((p) => p.isRookie);
    return 'ROOKIES ($rookiesAmount/3)';
  }

  String rookieName(int rookieNumber, isYellow) => isYellow
      ? (gialliByNumbers.containsKey(rookieNumber) ? gialliByNumbers[rookieNumber]!.name : '')
      : (verdiByNumbers.containsKey(rookieNumber) ? verdiByNumbers[rookieNumber]!.name : '');

  bool isPicked(Player p, bool isYellow) =>
      isYellow ? gialliByNumbers[p.number] != null : verdiByNumbers[p.number] != null;

  bool enableCheckbox(Player p, bool isYellow) {
    if (isYellow) {
      return gialliByNumbers.containsKey(p.number) ||
          (gialliByNumbers.length < _playerAmount && !verdiByNumbers.containsKey(p.number));
    }
    return verdiByNumbers.containsKey(p.number) ||
        (verdiByNumbers.length < _playerAmount && !gialliByNumbers.containsKey(p.number));
  }

  String getKeeper(bool isYellow) {
    return isYellow
        ? gialliByNumbers.values.toList().where((p) => p.number == YELLOW_KEEPER).length.toString()
        : verdiByNumbers.values.toList().where((p) => p.number == GREEN_KEEPER).length.toString();
  }

  bool isMobile() => Platform.isFuchsia || Platform.isAndroid || Platform.isIOS;
}
