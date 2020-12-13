import 'package:flutter/material.dart';
import 'package:login_page/add_listing.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/rest_api/nested_object.dart';

class ChooseCategoryScreen extends StatelessWidget {
  NestedObject nestedCategory;

  ChooseCategoryScreen({this.nestedCategory});

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
                          builder: (context) => AddListing(
                                chosenCategory: category.name,
                              )));
                }
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChooseCategoryScreen(nestedCategory: category)));
                }));
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: SingleChildScrollView(
        child: Column(
          children: _buildCategories(context),
        ),
      ),
    );
  }
}
