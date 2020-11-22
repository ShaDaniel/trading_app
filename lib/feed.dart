import 'package:flutter/material.dart';
import 'package:login_page/rest_api/listings.dart';

import 'rest_api/api.dart';

class FeedList extends StatefulWidget {
  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  final _listings = <Listing>[];
  int page = 1;
  int res = 0;
  bool fetching = false;

  void _loadMoreListings() {
    fetching = true;
    API().getListings(pageNum: page).then((value) {
      setState(() {
        if (value != null) {
          if (value?.count == null) {
            res = 0;
            return;
          }
          _listings.addAll(value.results);
          res = value.results.length;
          page++;
          fetching = false;
          print(_listings.length);
        }
      });
    });
  }

  Widget _buildAdvertisements() {
    return ListView.builder(
        itemExtent: 300,
        itemCount: _listings.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _listings.length) {
            if (!fetching) {
              _loadMoreListings();
            }
            if (res == 0) {
              return Divider();
            }
          }
          return Container(
              height: 300,
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
  void initState() {
    super.initState();
    _loadMoreListings();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAdvertisements();
  }
}
