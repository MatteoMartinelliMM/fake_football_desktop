import 'package:fake_football_desktop/model/player.dart';

class TeamMakingState {
  late List<Player> players;
  late List<Player> rookies;
  late int currentTab;
  Map<int, Player> gialli = {};
  Map<int, Player> verdi = {};
}

class LoadingPlayersState extends TeamMakingState {}

class PlayersLoadedState extends TeamMakingState {}

class TeamsFulledState extends TeamMakingState {}

class SingleTeamFulledState extends TeamMakingState {
  int tabPosition;

  SingleTeamFulledState(this.tabPosition);
}

class ThingsDoneState extends TeamMakingState {
  String text;

  ThingsDoneState(this.text);
}

class RiepilogoCopiedState extends ThingsDoneState {
  RiepilogoCopiedState(super.text);
}
