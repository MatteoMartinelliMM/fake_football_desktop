// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';

enum EventStatus {
  NOT_EXIST(0),
  NOT_WATCHED(1),
  WATCHED(2);

  final short value;

  const EventStatus(this.value);
}
