// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';

enum MatchState {
  NONE(0),
  INIZIO_PARTITA(1),
  FINE_PRIMO_TEMPO(2),
  INIZIO_SECONDO_TEMPO(3),
  FINE_PARTITA(5);

  final short value;

  const MatchState(this.value);
}
