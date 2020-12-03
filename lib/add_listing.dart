import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/main4screen.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/rest_api/api.dart';
import 'package:login_page/rest_api/listing_create.dart';

import 'common_elements/buttons.dart';
import 'common_elements/text_fields.dart';

class AddListing extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();
  final ListingRequest request = new ListingRequest();

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            child: SecondaryButton("Back", (context) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreens()));
            }, Icons.arrow_back_outlined),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 10),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                PrimaryTextField(
                  onSaved: (value) => request.title = value,
                  validator: (value) => (value as String).isEmpty
                      ? "The field is necessary"
                      : null,
                  labelText: "Title",
                ),
                PrimaryTextField(
                  onSaved: (value) => request.description = value,
                  labelText: "Description",
                  maxLines: 8,
                ),
                PrimaryTextField(
                  onSaved: (value) => request.category = value,
                  validator: (value) => (value as String).isEmpty
                      ? "The field is necessary"
                      : null,
                  labelText: "Category",
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryTextField(
                        onSaved: (value) => request.price = int.parse(value),
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
                        onSaved: (value) => request.quantity =
                            (value as String).isNotEmpty ? int.parse(value) : 0,
                        labelText: "Quantity",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                PrimaryButton("Create listing", listingCreate, [context])
              ],
            ),
          )
        ],
      ),
    );
  }

  void listingCreate(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Fluttertoast.showToast(
          msg: "Processing...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Color(0xffA67F8E),
          textColor: Color(0xff2C1A1D),
          fontSize: 25.0);
      new API().listingCreate(request).then((value) {
        if (value?.uuid != null) {
          Fluttertoast.showToast(
              msg: "Listing created!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Color(0xffA67F8E),
              textColor: Color(0xff2C1A1D),
              fontSize: 25.0);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreens()));
        }
        print(value?.uuid);
      });
    }
  }
}
