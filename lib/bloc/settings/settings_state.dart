import 'package:file_picker/file_picker.dart';

abstract class SettingsState {
  SettingsState copy();
}

class LoadState extends SettingsState {
  @override
  SettingsState copy() => LoadState();
}

class PathLoadedState extends SettingsState {
  Map<String, dynamic> paths;

  PathLoadedState(this.paths);

  @override
  SettingsState copy() => PathLoadedState(paths);
}

class PickDirectoryState extends SettingsState {
  String contentKey;
  String initialPath;

  PickDirectoryState(this.contentKey, this.initialPath);

  @override
  SettingsState copy() => PickDirectoryState(contentKey, initialPath);
}

class PickFileState extends SettingsState {
  String contentKey;
  FileType fileType;
  String initialPath;

  PickFileState(this.contentKey, this.fileType, this.initialPath);

  @override
  PickFileState copy() => PickFileState(contentKey, fileType, initialPath);
}

class PickExeState extends SettingsState {
  String contentKey;

  PickExeState(this.contentKey);

  @override
  PickExeState copy() => PickExeState(contentKey);
}
