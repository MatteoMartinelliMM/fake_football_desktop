import 'package:fake_football_desktop/model/event.dart';
import 'package:flutter/material.dart';

class ClipTime extends StatelessWidget {
  const ClipTime({
    super.key,
    required this.currEvent,
    required this.minus,
    required this.plus,
    this.startTime = true,
  });

  final Event currEvent;
  final Function? minus, plus;
  final bool startTime;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularWhiteButton(
            const Icon(
              Icons.exposure_neg_1,
              color: Colors.black,
              size: 36,
            ),
            onTap: () => minus?.call(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    startTime ? 'CLIP START:' : 'CLIP END:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 36.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      startTime ? currEvent.startClip : currEvent.endClip,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CircularWhiteButton(
            const Icon(
              Icons.exposure_plus_1,
              color: Colors.black,
              size: 36,
            ),
            onTap: () => plus?.call(),
          ),
        ],
      ),
    );
  }
}

class CircularWhiteButton extends StatelessWidget {
  const CircularWhiteButton(
    this.icon, {
    super.key,
    required this.onTap,
  });

  final Function()? onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onTap?.call();
      },
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
      ),
    );
  }
}
