class HomeEvent {}

class EnterHomeEvent extends HomeEvent {}

class ActionPressedEvent extends HomeEvent {
  String action;

  ActionPressedEvent(this.action);
}

class RefreshEvent extends HomeEvent {
}

class OverflowMenuEvent extends HomeEvent {
  String action;

  OverflowMenuEvent(this.action);
}
