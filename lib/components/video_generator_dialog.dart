import 'package:flutter/material.dart';

class VideoGeneratorDialog extends StatelessWidget {
  VideoGeneratorDialog.buildDummyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double dialogSize = MediaQuery.of(context).size.width / 2;
    return Material(
      child: SimpleDialog(
        titlePadding: EdgeInsets.zero,
        elevation: 20,
        title: Container(
            height: AppBar().preferredSize.height,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 16),
              child: Text('THIS IS A DIALOG',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
            )),
        children: [
          Container(
            width: 275,
            height: 0,
          ),
        ],
      ),
    );
  }
}
