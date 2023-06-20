abstract class TimerState {
  final int millis;

  TimerState(this.millis);
}

class TimerInitialState extends TimerState {
  bool userStops;
  TimerInitialState({this.userStops = false}) : super(0);
}

class TimerTicked extends TimerState {
  TimerTicked(millis) : super(millis);
}

class TimerPaused extends TimerState {
  TimerPaused(millis) : super(millis);


}class PromptTimerValueState extends TimerState {
  PromptTimerValueState() : super(0);
}
class AskStopTimerState extends TimerState{
  AskStopTimerState(millis) : super(millis);

}


