import 'package:flutter/material.dart';
import 'package:login_page/feed.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/profile_space.dart';

class MainScreens extends StatefulWidget {
  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final pages = <Widget>[ProfilePage(), Container(), Container(), FeedList()];
  int _curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BasicPage(
        child: pages[_curIndex],
        bottomPanel: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color(0xffA67F8E),
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Color(0xff2C1A1D)))),
          child: BottomNavigationBar(
            onTap: (index) {
              _curIndex = index;
              setState(() {});
            },
            currentIndex: _curIndex,
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
