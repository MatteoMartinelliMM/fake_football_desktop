import 'package:flutter/material.dart';

class AppLifeCycleObserver extends WidgetsBindingObserver {
  Function() onPause;
  Function() onResume;

  AppLifeCycleObserver({required this.onPause, required this.onResume});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        onPause.call();
        break;
      case AppLifecycleState.resumed:
        onResume.call();
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }
}
