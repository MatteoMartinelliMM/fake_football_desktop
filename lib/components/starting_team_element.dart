import 'package:fake_football_desktop/model/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartingTeamElement extends StatelessWidget {
  final Player p;
  final double imageWidth;
  final BuildContext context;

  const StartingTeamElement(this.context, this.p, this.imageWidth, {super.key});

  @override
  Widget build(BuildContext ctxt) {
    if (p.isRookie) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/squad/${p.assetDirName}/${p.playerMezzoBustoNamed}',
            filterQuality: FilterQuality.high,
          ),
          Positioned(
              bottom: 7,
              left: 16,
              child: SizedBox(
                height: imageWidth * 0.002,
                width: imageWidth * 0.45,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    p.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: p.accentColor),
                  ),
                ),
              ))
        ],
      );
    }
    return Image.asset('assets/squad/${p.assetDirName}/${p.playerMezzoBustoNamed}');
  }
}
