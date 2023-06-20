import 'package:flutter/material.dart';

class PlayerPicking extends StatelessWidget {
  String image;
  bool enable;

  PlayerPicking(this.image, this.enable, {super.key});

  @override
  Widget build(BuildContext context) {
    return !enable
        ? ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
            child: Image.asset(image))
        : Image.asset(image);
  }
}
