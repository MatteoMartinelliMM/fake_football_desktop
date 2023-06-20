import 'package:flutter/material.dart';

class OneButtonTracking extends StatelessWidget {
  Function onTap;

  Widget child;

  OneButtonTracking({required this.child, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0,  left: 16, right: 16, bottom: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: InkWell(
            onTap: () => onTap(),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
