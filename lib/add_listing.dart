import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/listing_choose_category.dart';
import 'package:login_page/listing_view.dart';
import 'package:login_page/main4screen.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/rest_api/api.dart';
import 'package:login_page/rest_api/listing_create.dart';
import 'package:login_page/rest_api/listings.dart';
import 'package:login_page/rest_api/nested_object.dart';

import 'common_elements/buttons.dart';
import 'common_elements/text_fields.dart';

enum ListingAction { Create, Update }

class CreateUpdateListing extends StatelessWidget {
  // Огромный нечитабельный уродец.

  final _formKey = new GlobalKey<FormState>();
  final ListingRequest request = new ListingRequest();
  Map<String, dynamic> jsonCategories;
  NestedObject categories;
  String chosenCategory;
  Listing updatingListing;

  CreateUpdateListing({this.chosenCategory, this.updatingListing});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().getCategoriesGoods(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> response) {
          if (response.connectionState != ConnectionState.done) {
            print("not done yet");
            return BasicPage(
                child: Center(
                    child: CircularProgressIndicator(
              backgroundColor: Color(0xff2C1A1D),
            )));
          } else {
            jsonCategories = response.data;
            categories = NestedObject(name: "categories")
                .fromJson(jsonCategories)
                .objects[0];

            return BasicPage(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: SecondaryButton("Back", (context) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreens()));
                    }, Icons.arrow_back_outlined),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        PrimaryTextField(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseCategoryScreen(
                                          nestedCategory: categories,
                                          updatingListing: updatingListing,
                                        )));
                          },
                          initialValue:
                              chosenCategory ?? updatingListing?.category,
                          onSaved: (value) => request.category = value,
                          readOnly: true,
                          validator: (value) => (value as String).isEmpty
                              ? "The field is necessary"
                              : null,
                          labelText: "Category",
                        ),
                        PrimaryTextField(
                          initialValue: updatingListing?.title,
                          onSaved: (value) => request.title = value,
                          validator: (value) => (value as String).isEmpty
                              ? "The field is necessary"
                              : null,
                          labelText: "Title",
                        ),
                        PrimaryTextField(
                          initialValue: updatingListing?.description,
                          onSaved: (value) => request.description = value,
                          labelText: "Description",
                          maxLines: 8,
                        ),
                        /*PrimaryTextField(
                          onSaved: (value) => request.category = value,
                          validator: (value) => (value as String).isEmpty
                              ? "The field is necessary"
                              : null,
                          labelText: "Category",
                        ),*/
                        //_buildCategories(categories),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryTextField(
                                initialValue: updatingListing?.quantity != null
                                    ? updatingListing.quantity.toString()
                                    : "",
                                onSaved: (value) =>
                                    request.price = int.parse(value),
                                validator: (value) => (value as String).isEmpty
                                    ? "The field is necessary"
                                    : null,
                                labelText: "Price",
                                postIcon: Icon(Icons.attach_money),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Expanded(
                              child: PrimaryTextField(
                                initialValue: updatingListing?.quantity != null
                                    ? updatingListing.quantity.toString()
                                    : "",
                                onSaved: (value) => request.quantity =
                                    (value as String).isNotEmpty
                                        ? int.parse(value)
                                        : 0,
                                labelText: "Quantity",
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        updatingListing == null
                            ? PrimaryButton(
                                "Create listing",
                                listingCreateUpdate,
                                [context, ListingAction.Create])
                            : PrimaryButton(
                                "Update listing",
                                listingCreateUpdate,
                                [context, ListingAction.Update]),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
          }
        });
  }

  void listingCreateUpdate(BuildContext context, ListingAction action) {
    // Почему бы не сделать два разных метода вместо енама и свича? -42

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Fluttertoast.showToast(
          // Там же целый файл с враппером для этой штуки есть.
          msg: "Processing...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Color(0xffA67F8E),
          textColor: Color(0xff2C1A1D),
          fontSize: 25.0);
      switch (action) {
        case ListingAction.Create:
          new API().listingCreate(request).then((value) {
            if (value?.uuid != null) {
              Fluttertoast.showToast(
                  msg: "Listing created!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Color(0xffA67F8E),
                  textColor: Color(0xff2C1A1D),
                  fontSize: 25.0);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreens()));
            }
          });
          break;

        case ListingAction.Update:
          new API().listingUpdate(request, updatingListing.uuid).then((value) {
            if (value?.uuid != null) {
              Fluttertoast.showToast(
                  msg: "Listing updated!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Color(0xffA67F8E),
                  textColor: Color(0xff2C1A1D),
                  fontSize: 25.0);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListingViewScreen(
                            listingInfo: value,
                          )));
            }
          });
          break;
      }
    }
  }
}
