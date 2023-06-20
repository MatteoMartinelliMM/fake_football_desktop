// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';

enum EventType {
  NONE(0),
  INIZIO_PARTITA(1),
  FINE_PRIMO_TEMPO(2),
  INIZIO_SECONDO_TEMPO(3),
  FINE_PARTITA(4),
  GOAL(5),
  ASSIST(6),
  QUASI_GOAL(7),
  RIGORI(8),
  PAPERE(9),
  BOTTE(10),
  AL_BARETTO(11),
  LOL_REGIA(12),
  MVP(13),
  INTERVISTA(14),
  PRESENZE(15);

  final short value;

  const EventType(this.value);
}
