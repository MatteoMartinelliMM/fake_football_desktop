import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:flutter/material.dart';

class PlayerGameGridElement extends StatelessWidget {
  const PlayerGameGridElement(
      {super.key,
      required this.width,
      required this.player,
      required this.onTap,
      this.type = PLAYER_MEZZO_BUSTO_NAMED});

  final Player player;
  final Function() onTap;
  final double width;
  final String type;

  @override
  Widget build(BuildContext context) {
    print('element width: $width');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: width,
          width: width,
          child: Stack(
            alignment: Alignment.bottomLeft,
            clipBehavior: Clip.none,
            children: [
              Ink.image(
                image: AssetImage(
                    'assets/squad/${player.assetDirName}/${type == PLAYER_MEZZO_BUSTO_NAMED ? player.playerMezzoBustoNamed : player.cardSocial}'),
                fit: BoxFit.contain,
                child: InkWell(
                  borderRadius: BorderRadius.circular(35.0),
                  splashColor: player.isYellow ? Colors.yellow : Colors.green.shade500,
                  onTap: () => onTap.call(),
                ),
              ),
              Positioned(
                  right: 10,
                  top: 10,
                  child: Visibility(
                      visible: player.isMvp, child: const Icon(Icons.star, color: Colors.yellow))),
              Visibility(
                visible: player.isRookie,
                child: Positioned(
                  left: player.name.length> 5 ? 40 : 60,
                  //left: 60,
                  //right: width /4,
                  child: Text(
                    player.name.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: player.accentColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width / 1.8,
                child: Visibility(
                    visible: player.isMvp,
                    child: const Icon(Icons.star, color: Colors.yellow)),
              ),

              Positioned(
                bottom: 50,
                child: Visibility(
                  visible: player.isRookie,
                  child: Text(
                    player.name.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: player.isYellow ? Colors.black : Colors.white,
                        ),
                  ),
                ),
              )
            ],
          ),*/
