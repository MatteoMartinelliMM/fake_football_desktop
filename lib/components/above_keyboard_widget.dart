import 'package:flutter/cupertino.dart';

class AboveKeyboard extends StatelessWidget {
  Widget child;
  bool enabled;

  AboveKeyboard({super.key, required this.child, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return enabled ? Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: child,
    ) : child;
  }
}
