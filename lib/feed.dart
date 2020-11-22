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
    return ListView.separated(
        itemCount: _listings.length,
        separatorBuilder: (context, i) => Divider(),
        itemBuilder: (context, i) {
          if (i >= _listings.length) {
            if (!fetching && res != 0) {
              _loadMoreListings();
            }
          }
          return Container(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              "lib/pics/${i % 6 + 1}.png",
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          _listings[i].title,
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff2C1A1D),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${_listings[i].price.toString()}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff2C1A1D),
                          ),
                        ),
                      ]),
                  (i + 1) >= _listings.length
                      ? Container(
                          width: 200,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    "lib/pics/${(i + 1) % 6 + 1}.png",
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                _listings[i + 1].title,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color(0xff2C1A1D),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$${_listings[i + 1].price.toString()}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff2C1A1D),
                                ),
                              ),
                            ]),
                ],
              ));
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
