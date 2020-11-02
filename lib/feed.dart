import 'package:flutter/material.dart';
import 'package:login_page/main4screen.dart';

class FeedList extends StatefulWidget {
  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  Widget _buildAdvertisements() {
    return ListView.builder(
        itemExtent: 300,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          return Container(
              height: 300,
              //title: Text("Ad #$index\nSpecial offer!"),
              child: Column(children: [
                Text(
                  "Geese Movements #$index",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff2C1A1D),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  "lib/pics/${index % 6 + 1}.png",
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Some nice thic gooser don't ya think?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff2C1A1D),
                      fontWeight: FontWeight.bold),
                ),
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildAdvertisements();
  }
}
