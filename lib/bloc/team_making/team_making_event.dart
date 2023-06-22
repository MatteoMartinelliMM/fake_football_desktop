import 'package:fake_football_desktop/model/player.dart';

class TeamMakingEvent {}

class LoadPlayersEvent extends TeamMakingEvent {}

class TeamMakingDisposeEvent extends TeamMakingEvent {}

class ChooseRookieNumber extends TeamMakingEvent {
  Player p;
  String? number;
  bool isYellow;

  ChooseRookieNumber(this.p, this.number, this.isYellow);
}

class SoccerModeChangeEvent extends TeamMakingEvent {
  String value;

  SoccerModeChangeEvent(this.value);
}

class TabChangeEvent extends TeamMakingEvent {
  int tab;
  TabChangeEvent(this.tab);
}

class PlayerPickedEvent extends TeamMakingEvent {
  Player playerPicked;
  bool isYellow;
  bool checked;

  PlayerPickedEvent(this.playerPicked, this.checked, this.isYellow);
}

class TeamConfifermedEvent extends TeamMakingEvent {}

class RiepilogoPresentiEvent extends TeamMakingEvent {}

class TeamMakingShuffleEvent extends TeamMakingEvent {}

class PageChangeEvent extends TeamMakingEvent {
  int page;
  PageChangeEvent(this.page);
}
