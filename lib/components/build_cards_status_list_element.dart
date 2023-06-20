
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:flutter/material.dart';

class BuildCardStatusListItem extends StatelessWidget {
  Player p;
  bool exist;


  BuildCardStatusListItem(this.p, this.exist);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: getPlayerCard(p, exist),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.38,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    p.distinta,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                  ),
                ),
                const Spacer(),
                Icon(
                  exist ? Icons.check : Icons.close,
                  color: exist ? Colors.green : Colors.red,
                  size: 50,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Image getPlayerCard(Player p, bool exist) {
    if (exist) {
      return Image.file(PathProvider.getCardPortiere(p));
    }

    if (p.isYellow) {
      return Image.asset('assets/squad/rookie/yellowCardRookie.png');
    }
    return Image.asset('assets/squad/rookie/greenCardRookie.png');
  }
}
