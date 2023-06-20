import 'dart:math';

import 'package:flutter/material.dart';

class FakeFootballProgressIndicator extends StatefulWidget {
  const FakeFootballProgressIndicator({super.key});

  @override
  State<StatefulWidget> createState() => FakeFootballProgressIndicatorState();
}

class FakeFootballProgressIndicatorState extends State<FakeFootballProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: 2 * pi * _animationController.value,
          child: SizedBox(
            width: 75,
            height: 75,
            child: Image.asset(
              'assets/images/logo_fakefootball.png',
              filterQuality: FilterQuality.low,
            ),
          ), // Replace with your actual image asset path
        );
      },
    );
  }
}
