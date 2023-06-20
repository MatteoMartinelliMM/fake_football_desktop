import 'package:fake_football_desktop/components/starting_team_element.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StartingTeamWidget extends StatelessWidget {
  BuildContext? context;
  double? height, width;
  late double fieldWidth, fieldHeight;
  late final String matchType;
  final Map<String, List<Player>> playersPerFieldZone;

  StartingTeamWidget(this.playersPerFieldZone, int nrOfPlayer, [this.context, this.height, this.width]) {
    width = width ?? 1080;
    height = height ?? 1920;
    fieldWidth = width! * 0.3;
    fieldHeight = height! * 0.2;
    matchType = nrOfPlayer == 7 ? 'VII' : 'V';
  }

  @override
  Widget build(BuildContext ctxt) {
    ctxt = context ?? ctxt;
    Player keeper = playersPerFieldZone[POR]!.first;
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/${keeper.isYellow ? 'startingIXGialli' : 'startingIXVerdi'}.png',
            filterQuality: FilterQuality.high,
          ),
        ),
        Positioned(
            top: -2,
            child: SizedBox(
              width: fieldHeight,
              height: height! * 0.15,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'STARTING',
                    style: Theme.of(ctxt)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: keeper.primaryColor, fontSize: 24),
                  ),
                  Text(
                    matchType,
                    style: Theme.of(ctxt)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: keeper.primaryColor, fontSize: 75),
                  ),
                ],
              ),
            )),
        Positioned(
          bottom: height! * 0.115,
          child: SizedBox(
            width: fieldWidth,
            height: fieldHeight,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children:
                  _buildLineUpByFieldZone(ctxt, playersPerFieldZone, fieldWidth, fieldHeight),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildLineUpByFieldZone(BuildContext context,
      Map<String, List<Player>> playersByFieldZone, double fieldWidth, double fieldHeight) {
    return playersByFieldZone.keys.map((fieldZone) {
      int howManyPlayers = playersByFieldZone[fieldZone]!.length;
      int i = 0;
      return Positioned(
        bottom: fieldHeight - (fieldHeight * fieldZone.fieldPositionKByRole()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: playersByFieldZone[fieldZone]!.map(
            (e) {
              Widget w = Padding(
                padding: EdgeInsets.only(
                    left: howManyPlayers != 4 ? 16 : 4,
                    right: howManyPlayers != 4 ? 16 : 4,
                    bottom: howManyPlayers > 2 && (i == 0 || i == howManyPlayers - 1) ? 25 : 0,
                    top: howManyPlayers > 2 && (i == 1 || i == 2) ? 25 : 0),
                child: SizedBox(
                  height: fieldHeight * 0.22,
                  child: StartingTeamElement(context, e, fieldHeight * 0.22),
                ),
              );
              i++;
              return w;
            },
          ).toList(),
        ),
      );
    }).toList();
  }
}
