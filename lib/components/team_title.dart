import 'package:flutter/material.dart';

class FakeFootballTitle extends StatelessWidget {
  String title;
  Color color;
  bool half;

  FakeFootballTitle({super.key, required this.title, this.half = false, required this.color});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: half
            ? (MediaQuery.of(context).size.width / 3) / 2
            : (MediaQuery.of(context).size.width / 3),
        height: 5,
        color: color,
      ),
      Flexible(
        child: SizedBox(
          width: half
              ? (MediaQuery.of(context).size.width / 3) / 2
              : MediaQuery.of(context).size.width / 3,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                  ),
            ),
          ),
        ),
      ),
      Container(
        width: half
            ? (MediaQuery.of(context).size.width / 3) / 2
            : MediaQuery.of(context).size.width / 3,
        height: 5,
        color: color,
      ),
    ],
  );
}
