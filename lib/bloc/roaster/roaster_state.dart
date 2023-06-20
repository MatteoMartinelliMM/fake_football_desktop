import 'package:fake_football_desktop/model/player.dart';

abstract class RoasterState {}

class LoadingState extends RoasterState {}

class CloseState extends RoasterState {}

class PlayersLoadedState extends RoasterState {
  List<Player> players;

  PlayersLoadedState(this.players);
}

class RiepilogoSinglePlayerState extends RoasterState {
  Player player;

  RiepilogoSinglePlayerState(this.player);
}

class CreatePlayerState extends RoasterState {
  Player p;
  int maxRoleLength;

  CreatePlayerState(this.p, this.maxRoleLength);
}

class RookieAlreadyExistState extends CreatePlayerState {

  RookieAlreadyExistState(super.p, super.maxRoleLength);
}
