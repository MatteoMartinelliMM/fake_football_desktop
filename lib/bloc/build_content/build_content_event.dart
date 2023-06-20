class BuildGameContentEvent {}

class LoadPageEvent extends BuildGameContentEvent {}

class PageLoadedEvent extends BuildGameContentEvent {}

class ChooseModuloEvent extends BuildGameContentEvent {
  String? modulo;

  bool isYellow;

  ChooseModuloEvent(this.modulo, this.isYellow);
}

class ModuliAlreadyChoosenEvent extends BuildGameContentEvent {}

class RefreshEvent extends BuildGameContentEvent {}

class NextEvent extends BuildGameContentEvent {}

class BuildContentDisposeEvent extends BuildGameContentEvent {}

