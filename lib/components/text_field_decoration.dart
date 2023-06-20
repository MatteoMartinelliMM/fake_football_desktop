import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/material.dart';

class FakeFootballDecoration {
  static InputDecoration inputDecoration(
      {String? hintText, String? labelText, Icon? prefixIcon, String? errorLabel}) {
    return InputDecoration(
        hintText: hintText,
        errorBorder: !errorLabel.isNullOrEmpty()
            ? OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.red), //<-- SEE HERE
                borderRadius: BorderRadius.circular(5.0),
              )
            : null,
        errorText: errorLabel,
        labelText: labelText,
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.yellow), //<-- SEE HERE
          borderRadius: BorderRadius.circular(5.0),
        ));
  }
}
