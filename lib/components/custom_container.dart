import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  Widget child;
  bool withBorder;

  CustomContainer({super.key, required this.child, this.withBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: withBorder ? divideScreen() : null,
      width: kIsWeb ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width,
      height: !kIsWeb ? (getHeight(context) / 2) -30 : getHeight(context),
      child: child,
    );
  }
}

double getHeight(BuildContext context) =>
    MediaQuery.of(context).size.height -
    (Scaffold.of(context).appBarMaxHeight != null ? Scaffold.of(context).appBarMaxHeight! : 0.0);

BoxDecoration divideScreen() => const BoxDecoration(
    border: kIsWeb
        ? Border(right: BorderSide(color: Colors.white70, width: 2.0))
        : Border(bottom: BorderSide(color: Colors.white70, width: 2.0)));
