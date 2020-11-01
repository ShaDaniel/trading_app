import 'package:flutter/material.dart';
import 'package:login_page/page_templates.dart';

class LogoutPage extends StatefulWidget {
  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
        child: Center(
            child: Text(
      "You have been logged out.",
      style: TextStyle(
          fontSize: 50, color: Color(0xff2C1A1D), fontWeight: FontWeight.bold),
    )));
  }
}
