import 'package:flutter/material.dart';

class TrackingTwoButtons extends StatelessWidget {
  Function leftTap, rightTap;
  bool enabled;
  Widget leftChild, rightChild;

  TrackingTwoButtons(
      {required this.leftChild,
      required this.rightChild,
      required this.leftTap,
      required this.rightTap,
      this.enabled = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                color: enabled ? Colors.white : Colors.grey.shade400,
                elevation: 2,
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: enabled ? () => leftTap() : null,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: leftChild,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 2,
                color: enabled ? Colors.white : Colors.grey.shade400,
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: enabled ? () => rightTap() : null,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: rightChild,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
