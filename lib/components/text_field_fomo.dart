import 'package:flutter/material.dart';
import 'package:fake_football_desktop/utils/constants.dart';

class TextFieldFomo extends StatefulWidget {
  Function(String)? onChanged;
  Function? onEditingComplete;
  TextEditingController? controller;
  InputDecoration? decoration;

  TextFieldFomo({
    super.key,
    this.controller,
    this.decoration,
    this.onEditingComplete,
    this.onChanged,
  });

  @override
  _TextFieldFomoState createState() => _TextFieldFomoState();
}

class _TextFieldFomoState extends State<TextFieldFomo> {
  late FocusNode _focus;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    _focus.addListener(_onFocusChange);
    textEditingController =
        widget.controller != null ? widget.controller! : TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    print("DIPRE PAURA PORCODIOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    if (!_focus.hasFocus) {
      widget.onEditingComplete?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focus,
      onChanged: (value) => widget.onChanged?.call(value),
      controller: textEditingController,
      decoration: widget.decoration,
    );
  }
}
