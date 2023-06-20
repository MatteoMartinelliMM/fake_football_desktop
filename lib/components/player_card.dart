import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  String image;
  bool isYellow;

  PlayerCard({super.key, required this.image, required this.isYellow});

  @override
  Widget build(BuildContext context) {
    Image i;
    try {
      i = Image.asset(image);
    } catch (_) {
      String path =
          isYellow ? 'assets/squad/rookie/yellowCardRookie.png' : 'assets/squad/rookie/greenCardRookie.png';
      i = Image.asset(path);
    }
    return i;
  }
}
