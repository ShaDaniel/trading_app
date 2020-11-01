import 'package:flutter/material.dart';
import 'package:login_page/page_templates.dart';

class MainScreens extends StatefulWidget {
  final Widget child;

  MainScreens({this.child});
  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
        child: widget.child,
        bottomPanel: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color(0xffA67F8E),
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Color(0xff2C1A1D)))),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "profile"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail_outline), label: "messages"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.all_inclusive_sharp), label: "feed"),
            ],
            selectedItemColor: Color(0xff2C1A1D),
            unselectedItemColor: Color(0xff6C534E),
          ),
        ));
  }
}
