// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fake_football_desktop/bloc/timer/timer_bloc.dart';
import 'package:fake_football_desktop/bloc/timer/timer_event.dart';
import 'package:fake_football_desktop/bloc/timer/timer_state.dart';
import 'package:fake_football_desktop/components/tracking_one_button.dart';
import 'package:fake_football_desktop/components/tracking_two_buttons_row.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

//import 'package:screen/screen.dart';
import 'dart:io' show Platform;

import 'package:wakelock/wakelock.dart';

class TimerWidget extends StatefulWidget {
  static const String route = '/simpleGameTracking/';
  final Function? onTimerStart, onTimerStop;
  final DateFormat _dateFormat = DateFormat(TIMER_FORMAT);

  TimerWidget({super.key, this.onTimerStart, this.onTimerStop});

  @override
  State<StatefulWidget> createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
  //  BlocProvider.of<TimerBloc>(context).add(StopTimerEvent());
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<TimerBloc, TimerState>(
      listenWhen: (previous, current) =>
          current is AskStopTimerState || current is TimerInitialState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case AskStopTimerState:
            _showAlertDialog(context);
            break;
          case TimerInitialState:
            state as TimerInitialState;
            if (state.userStops) widget.onTimerStop?.call();
            break;
        }
      },
      buildWhen: (prev, curr) => curr is! AskStopTimerState,
      builder: (context, state) {
        final String formattedTime = widget._dateFormat.format(
          DateTime.fromMillisecondsSinceEpoch(state.millis, isUtc: true),
        );
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  color: Colors.white,
                  child: Center(
                    child: showTime(formattedTime, context, state),
                  ),
                ),
              ),
              buttonsByState(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget showTime(String formattedTime, BuildContext context, TimerState timerState) {
    //print('ui TimerTicked: ${context.read<TimerBloc>().currentMillis}');
    return timerState is! TimerPaused
        ? GestureDetector(
            onLongPress: () => context.read<TimerBloc>().add(ChangeTimerValueManuallyEvent()),
            child: Text(
              formattedTime,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.black87),
            ),
          )
        : FadeTransition(
            opacity: _controller,
            child: Text(
              formattedTime,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.black87),
            ));
  }

  Widget buttonsByState(BuildContext context, TimerState state) {
    switch (state.runtimeType) {
      case TimerInitialState:
        return OneButtonTracking(
          child: const Icon(
            Icons.fiber_manual_record,
            color: Colors.red,
          ),
          onTap: () {
            widget.onTimerStart?.call();
            context.read<TimerBloc>().add(StartTimerEvent());
          },
        );
      case TimerTicked:
        return TrackingTwoButtons(
          leftChild: const Icon(
            Icons.pause,
            color: Colors.green,
          ),
          rightChild: const Icon(
            Icons.stop,
            color: Colors.red,
          ),
          leftTap: () => context.read<TimerBloc>().add(PauseTimerEvent()),
          rightTap: () => context.read<TimerBloc>().add(StopTimerEvent()),
        );
      case TimerPaused:
        return TrackingTwoButtons(
          leftChild: const Icon(
            Icons.play_arrow,
            color: Colors.green,
          ),
          rightChild: const Icon(
            Icons.stop,
            color: Colors.red,
          ),
          leftTap: () => context.read<TimerBloc>().add(StartTimerEvent()),
          rightTap: () => context.read<TimerBloc>().add(StopTimerEvent()),
        );
    }
    return Container();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attenzione'),
          content: const Text('Sei sicuro di voler stoppare il timer e concludere la partita?'),
          actions: [
            TextButton(
              child: const Text('NO'),
              onPressed: () {
                context.read<TimerBloc>().add(ConfirmStopTimerEvent(false));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('SI'),
              onPressed: () {
                context.read<TimerBloc>().add(ConfirmStopTimerEvent(true));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    Wakelock.disable();
  }
}
