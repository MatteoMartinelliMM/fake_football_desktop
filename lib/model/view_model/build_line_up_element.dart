// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';

class BuildLineUpObject {
  Player p;
  List<Player> othersPlayer;
  bool esito;

  BuildLineUpObject(this.p, this.othersPlayer, this.esito);
}
