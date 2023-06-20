import 'dart:io';

import 'package:fake_football_desktop/components/player_card.dart';
import 'package:fake_football_desktop/model/view_model/build_line_up_element.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BuildLineUpListElement extends StatelessWidget {
  BuildLineUpObject object;

  BuildLineUpListElement(this.object, {super.key});

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
              child: Image.file(PathProvider.getCardPortiere(object.p)),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
                child: Text(
              object.othersPlayer.map((e) => e.distinta).join(' '),
              style: Theme.of(context).textTheme.titleLarge,
            )),
          ),
        ),
        Icon(
          object.esito ? Icons.check : Icons.close,
          color: object.esito ? Colors.green : Colors.red,
          size: 50,
        )
      ],
    );
  }
}
