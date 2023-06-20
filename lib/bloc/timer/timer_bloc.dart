import 'dart:async';

import 'package:fake_football_desktop/bloc/timer/timer_event.dart';
import 'package:fake_football_desktop/bloc/timer/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  int _seconds = 0;
  final DateFormat _dateFormat = DateFormat('HH:mm:ss');

  Stream<TickEvent> get tickEvent => _tickEvent.stream;

  final StreamController<TickEvent> _tickEvent = StreamController<TickEvent>.broadcast();

  Stream<int> get onTick => _onTick.stream;

  final StreamController<int> _onTick = StreamController<int>.broadcast();

  TimerBloc() : super(TimerInitialState()) {
    on<StartTimerEvent>(_mapOnStartTimerEvent);
    on<PauseTimerEvent>(_mapOnPauseTimerEvent);
    on<StopTimerEvent>(_mapOnStopTimerEvent);
    on<ConfirmStopTimerEvent>(_mapOnConfirmStopTimerEvent);
    on<TimerTickedEvent>(_mapOnTimerTickedEvent);
    on<ChangeTimerValueManuallyEvent>(_mapOnChangeTimerValueManuallyEvent);
    on<TimerResumedEvent>(_mapOnTimerResumedEvent);
  }

  int get currentMillis {
    //('curr seconds: $_millis');
    //print('curr millis: ${_millis * 1000}');
    return _seconds * 1000;
  }

  bool get isActive => _timer?.isActive ?? false;

  String get currentMillisPrintable =>
      _dateFormat.format(DateTime.fromMillisecondsSinceEpoch((_seconds * 1000), isUtc: true));

  FutureOr<void> _mapOnStartTimerEvent(
    StartTimerEvent event,
    Emitter<TimerState> emit,
  ) async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      add(TimerTickedEvent(currentMillis));
    });
    emit(TimerTicked(currentMillis));
  }

  FutureOr<void> _mapOnTimerTickedEvent(
    TimerTickedEvent event,
    Emitter<TimerState> emit,
  ) async {
    emit(TimerTicked(event.millis));
  }

  FutureOr<void> _mapOnPauseTimerEvent(
    PauseTimerEvent event,
    Emitter<TimerState> emit,
  ) async {
    if (_timer?.isActive == true) {
      _timer?.cancel();
      emit(TimerPaused(currentMillis));
    } else {
      emit(TimerTicked(currentMillis));
    }
  }

  FutureOr<void> _mapOnStopTimerEvent(
    StopTimerEvent event,
    Emitter<TimerState> emit,
  ) async {
    emit(AskStopTimerState(currentMillis));
  }

  FutureOr<void> _mapOnConfirmStopTimerEvent(
    ConfirmStopTimerEvent event,
    Emitter<TimerState> emit,
  ) {
    if (event.esito) {
      _timer?.cancel();
      _seconds = 0;
      emit(TimerInitialState(userStops: true));
    }
  }

  FutureOr<void> _mapOnTimerResumedEvent(
    TimerResumedEvent event,
    Emitter<TimerState> emit,
  ) {
    _seconds += Duration(milliseconds: event.offsetMillis).inSeconds;
    emit(TimerTicked(currentMillis));
  }

  FutureOr<void> _mapOnChangeTimerValueManuallyEvent(
    ChangeTimerValueManuallyEvent event,
    Emitter<TimerState> emit,
  ) {
    _timer?.cancel();
    emit(PromptTimerValueState());
  }

}

class TickEvent {
  TimerState timerState;
  String time;

  TickEvent(this.timerState, this.time);
}
