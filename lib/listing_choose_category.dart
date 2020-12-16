import 'package:flutter/material.dart';

import 'package:login_page/add_listing.dart';
import 'package:login_page/common_elements/buttons.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/rest_api/listings.dart';
import 'package:login_page/rest_api/nested_object.dart';

class ChooseCategoryScreen extends StatelessWidget {
  NestedObject nestedCategory;
  Listing updatingListing;

  ChooseCategoryScreen({this.nestedCategory, this.updatingListing});

  List<Widget> _buildCategories(BuildContext context) {
    List<Widget> categories = new List<Widget>();

    for (var category in nestedCategory.objects) {
      categories.add(ListTile(
          title: Text(category.name),
          onTap: category.objects.isEmpty
              ? () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateUpdateListing(
                                chosenCategory: category.name,
                                updatingListing: updatingListing,
                              )));
                }
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChooseCategoryScreen(
                                nestedCategory: category,
                                updatingListing: updatingListing,
                              )));
                }));
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            child: SecondaryButton("Back", (context) {
              Navigator.pop(context);
            }, Icons.arrow_back_outlined),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 10),
          ),
          Column(
            children: _buildCategories(context),
          ),
        ],
      )),
    );
  }
}
