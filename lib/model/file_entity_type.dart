// ignore_for_file: constant_identifier_names

enum FileEntityType {
  DIRECTORY(0),
  FILE(1),
  EXE(2);

  final int value;

  const FileEntityType(this.value);
}
