import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const _baseTextStyle = TextStyle();

class ThemedText extends StatelessWidget {
  final TextType textType;
  final String message;
  final TextStyle textStyle;

  const ThemedText(
    this.message, {
    this.textType = TextType.text,
    this.textStyle = _baseTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      this.message,
      style: () {
        switch (this.textType) {
          case TextType.text:
            return TextStyle(
              fontSize: 16,
              color: this._lightMode(context) ? Colors.black : Colors.white,
            );
          case TextType.subtitle:
            return TextStyle(
              fontSize: 16,
              color: this._lightMode(context) ? Colors.grey[800] : Colors.grey[200],
            );
          case TextType.header:
            return TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: this._lightMode(context) ? Colors.black : Colors.white,
            );
          case TextType.selectable:
            return TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: this._lightMode(context) ? Colors.grey[800] : Colors.grey[400],
            );
        }
      }().merge(this.textStyle),
    );
  }

  bool _lightMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light;
  }
}

enum TextType {
  header,
  subtitle,
  text,
  selectable,
}
