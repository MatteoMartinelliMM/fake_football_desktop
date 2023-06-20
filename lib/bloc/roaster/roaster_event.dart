abstract class RiepilogoGiocatoriEvent {}

class EnterOnPageEvent extends RiepilogoGiocatoriEvent {}

class OverflowMenuEvent extends RiepilogoGiocatoriEvent {
  String action;

  OverflowMenuEvent(this.action);
}

class PlayerPickedEvent extends RiepilogoGiocatoriEvent {
  int position;

  PlayerPickedEvent(this.position);
}

class ChangeJerseyEvent extends RiepilogoGiocatoriEvent {
  int page;

  ChangeJerseyEvent(this.page);
}

class BackPressEvent extends RiepilogoGiocatoriEvent {}

class PlayerNameSubmittedEvent extends RiepilogoGiocatoriEvent {
  String name;

  PlayerNameSubmittedEvent(this.name);
}

class RolePickedEvent extends RiepilogoGiocatoriEvent {
  String? role;
  int affinity;

  RolePickedEvent(this.role, this.affinity);
}

class NameTypingEvent extends RiepilogoGiocatoriEvent {
  String value;

  NameTypingEvent(this.value);
}

class PlayerConfirmedEvent extends RiepilogoGiocatoriEvent {

  PlayerConfirmedEvent();
}
