import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/model/view_model/build_line_up_element.dart';

abstract class BuildGameContentState {
  String title;

  BuildGameContentState(this.title);
}

class LoadingContentState extends BuildGameContentState {
  LoadingContentState() : super('');
}

class ThinsDoneState extends BuildGameContentState {
  ThinsDoneState() : super('');
}

class LoadModuliAndConvocations extends BuildGameContentState {
  late List<String> moduli;
  late String playersGialli, playersVerdi;
  String? moduloGialli, moduloVerdi;

  LoadModuliAndConvocations() : super('Seleziona modulo');
}

class LoadModuliAndConvocationsSingleTeam extends BuildGameContentState {
  List<String> moduli;
  String players;
  String? teamModule;
  bool isYellow;

  LoadModuliAndConvocationsSingleTeam(this.moduli, this.players, this.teamModule, this.isYellow)
      : super('Seleziona modulo');
}

class BuildCardState extends BuildGameContentState {
  Map<Player, bool> dontHaveCardsGialli;
  Map<Player, bool> dontHaveCardsVerdi;
  bool esito;

  BuildCardState(this.dontHaveCardsGialli, this.dontHaveCardsVerdi, this.esito)
      : super('Carte mancanti');
}

class BuildLineUpState extends BuildGameContentState {
  List<BuildLineUpObject> giallLineUp;
  List<BuildLineUpObject> verdiLineUp;
  bool esito;

  BuildLineUpState(this.giallLineUp, this.verdiLineUp, this.esito) : super('Grafiche formazioni');
}
