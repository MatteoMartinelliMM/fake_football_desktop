import 'package:fake_football_desktop/bloc/timer/timer_bloc.dart';
import 'package:fake_football_desktop/bloc/timer/timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamTextWidget extends StatefulWidget {
  Stream<TickEvent> tickEvent;

  StreamTextWidget({required this.tickEvent});

  @override
  State<StreamTextWidget> createState() => _StreamTextWidgetState();
}

class _StreamTextWidgetState extends State<StreamTextWidget> with SingleTickerProviderStateMixin {
  TimerState timerState = TimerInitialState();
  String formattedTime = '00:00:00';

  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return timerState is! TimerPaused
        ? Text(
            formattedTime,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.black87),
          )
        : FadeTransition(
            opacity: _controller,
            child: Text(
              formattedTime,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.black87),
            ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.tickEvent.listen((event) {
      formattedTime = context.read<TimerBloc>().currentMillisPrintable;
      timerState = event.timerState;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }
}
