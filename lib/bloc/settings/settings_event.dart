
abstract class PathManagerEvent {}

class EnterPageEvent extends PathManagerEvent {}

class BackPressEvent extends PathManagerEvent {}

class PickPathEvent extends PathManagerEvent {
  String contentKey;
  String? path;


  PickPathEvent(this.contentKey, this.path);
}

class SettingSelectedEvent extends PathManagerEvent {
  String contentKey;

  SettingSelectedEvent(this.contentKey);
}
