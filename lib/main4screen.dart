import 'package:flutter/material.dart';
import 'package:login_page/add_listing.dart';
import 'package:login_page/common_elements/text_elements.dart';
import 'package:login_page/feed.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/profile_space.dart';
import 'common_elements/colors.dart' as colors;
import 'common_elements/globals.dart' as globals;

class MainScreens extends StatefulWidget {
  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final pages = <Widget>[FeedList(), ProfilePage(), Container(), Container()];
  int _curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BasicPage(
        appBar: _curIndex == 0
            ? AppBar(
                leading: Icon(Icons.menu),
                title: TextSecondary(text: globals.userLocationAddress ?? ""),
              )
            : null,
        child: pages[_curIndex],
        floatingBtn: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: colors.btnPlus,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateUpdateListing()));
          },
        ),
        bottomPanel: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              _curIndex = index;
              setState(() {});
            },
            currentIndex: _curIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.all_inclusive_sharp), label: "feed"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "profile"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail_outline), label: "messages"),
            ],
            selectedItemColor: Color(0xff2C1A1D),
            unselectedItemColor: Color(0xff6C534E),
          ),
        ));
  }
}
