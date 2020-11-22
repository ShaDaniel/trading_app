import 'package:flutter/material.dart';

class TextPrimary extends StatelessWidget {
  final String text;
  TextPrimary({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 50, color: Color(0xff2C1A1D), fontWeight: FontWeight.bold),
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
          color: Color(0xff2C1A1D),
          fontWeight: bold ? FontWeight.normal : FontWeight.bold),
    );
  }
}
