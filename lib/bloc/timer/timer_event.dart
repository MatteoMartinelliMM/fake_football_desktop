abstract class TimerEvent {}

class StartTimerEvent extends TimerEvent {}

class PauseTimerEvent extends TimerEvent {}

class TimerTickedEvent extends TimerEvent {
  int millis;

  TimerTickedEvent(this.millis);
}

class StopTimerEvent extends TimerEvent {}

class ConfirmStopTimerEvent extends TimerEvent {
  bool esito;

  ConfirmStopTimerEvent(this.esito);
}

class ChangeTimerValueManuallyEvent extends TimerEvent {}

class TimerResumedEvent extends TimerEvent {
  int offsetMillis;

  TimerResumedEvent(this.offsetMillis);
}
