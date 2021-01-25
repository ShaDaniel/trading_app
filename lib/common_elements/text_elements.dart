import 'package:flutter/material.dart';
import 'colors.dart' as colors;

// Это делается так:

class CustomText extends Text {
  CustomText(String text, double fontSize)
      : super(text, style: _CustomTextStyle(fontSize));
}

class _CustomTextStyle extends TextStyle {
  _CustomTextStyle(double fontSize)
      : super(
          fontSize: fontSize,
          color: colors.textMain,
          fontWeight: FontWeight.bold,
        );
}

// DRY

class TextPrimary extends StatelessWidget {
  final String text;
  TextPrimary({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 50, color: colors.textMain, fontWeight: FontWeight.bold),
    );
  }
}

class TextSesquialteral extends StatelessWidget {
  final String text;
  TextSesquialteral({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 35, color: colors.textMain, fontWeight: FontWeight.bold),
    );
  }
}

class TextSecondary extends StatelessWidget {
  final String text;
  final bool bold;
  TextSecondary({this.text, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          color: colors.textScndry,
          fontWeight: bold ? FontWeight.normal : FontWeight.bold),
    );
  }
}
