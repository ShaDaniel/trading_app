import 'package:flutter/material.dart';
import 'package:login_page/common_elements/text_elements.dart';
import 'package:login_page/page_templates.dart';

// Как именно может меняться состояние этого Stateful виджета?

class LogoutPage extends StatefulWidget {
  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
        child: Center(child: TextPrimary(text: "You have been logged out.")));
  }
}
