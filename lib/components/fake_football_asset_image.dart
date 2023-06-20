// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fake_football_desktop/model/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FakeFootballAssetImage extends StatelessWidget {
  final String baseAssetPath = 'assets/squad/';
  Player player;
  Function()? onTap;
  String image;

  FakeFootballAssetImage({super.key, required this.player, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? InkWell(
            onTap: () => onTap?.call(),
            splashColor: player.isYellow ? Colors.yellow : Colors.green,
            child: Image.asset('$baseAssetPath${player.assetDirName}/$image'),
          )
        : Image.asset('$baseAssetPath${player.assetDirName}/$image');
  }
}
