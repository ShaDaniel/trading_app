import 'package:flutter/material.dart';
import 'package:login_page/common_elements/text_elements.dart';
import 'package:login_page/rest_api/listings.dart';

import 'rest_api/api.dart';

class ListingPallet extends StatelessWidget {
  final Listing listing;
  ListingPallet({this.listing});

  @override
  Widget build(BuildContext context) {
    if (listing == null) return Container(width: 200);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            "lib/pics/1.png", // потом будет listing.photo[0]
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
      ),
      TextSecondary(text: listing.title, bold: true),
      TextSecondary(text: "\$${listing.price.toString()}"),
    ]);
  }
}

class FeedList extends StatefulWidget {
  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  // уже полученные объявления с бэка
  final _listings = <Listing>[];
  int page = 1;
  int res = 0;
  bool fetching = false;

  void _loadMoreListings() {
    fetching = true;
    API().getListings(pageNum: page).then((value) {
      setState(() {
        // если есть очередные объявления, добавляем в кэш
        if (value != null) {
          if (value?.count == null) {
            res = 0;
            return;
          }
          _listings.addAll(value.results);
          res = value.results.length;
          page++;
          fetching = false;
        }
      });
    });
  }

  Widget _buildAdvertisements() {
    return ListView.separated(
        itemCount: (_listings.length + 1) ~/ 2,
        separatorBuilder: (context, i) => Divider(),
        itemBuilder: (context, i) {
          // если кончились объявления в кэше, получаем с бэка
          if ((i + 1) * 2 >= _listings.length) {
            // локер для разных потоков
            if (!fetching && res != 0) {
              _loadMoreListings();
            }
            print(_listings.length);
          }
          return Container(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListingPallet(listing: _listings[i * 2]),
                  ListingPallet(
                      listing: i * 2 + 1 >= _listings.length
                          ? null
                          : _listings[i * 2 + 1]),
                ],
              ));
        });
  }

  @override
  void initState() {
    // при загрузке страницы получаем первую порцию объявлений
    super.initState();
    _loadMoreListings();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAdvertisements();
  }
}
