import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_page/add_listing.dart';
import 'package:login_page/common_elements/buttons.dart';
import 'package:login_page/common_elements/text_elements.dart';
import 'package:login_page/main4screen.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/rest_api/listings.dart';
import 'common_elements/globals.dart' as globals;

class ListingViewScreen extends StatelessWidget {
  // Нет сил разбирать эту простыню. Надо разбивать на отдельные виджеты.
  Listing listingInfo;

  ListingViewScreen({this.listingInfo});

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: SecondaryButton("Back", (context) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreens()));
                  }, Icons.arrow_back_outlined),
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 10),
                ),
                globals.userInfo.profile.uuid == listingInfo.seller.uuid
                    ? Container(
                        child: SecondaryButton(
                          "Edit",
                          (context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateUpdateListing(
                                          updatingListing: listingInfo,
                                        )));
                          },
                        ),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(right: 10),
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Image.asset(
              "lib/pics/no_image.png", // потом будет listing.photo[0]
              width: double.infinity,
              height: 250,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextSesquialteral(text: listingInfo.title),
                  TextSecondary(text: listingInfo.category),
                  SizedBox(
                    height: 15,
                  ),
                  TextSecondary(text: listingInfo.price.toString() + " руб."),
                  SizedBox(
                    height: 15,
                  ),
                  TextSecondary(text: listingInfo.description),
                  Divider(),
                  TextSecondary(
                      text: "Размещено: " +
                          DateFormat("kk:mm dd-MM-yyyy")
                              .format(listingInfo.date_created)),
                  TextSecondary(
                      text: "Просмотры: " + listingInfo.views.toString()),
                  TextSecondary(
                      text: "Количество: " + listingInfo.quantity.toString()),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Image.asset("lib/pics/profile.png",
                            width: 100, height: 100),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextSecondary(text: listingInfo.seller.full_name),
                          TextSecondary(
                              text: "Рейтинг продавца: " +
                                  listingInfo.seller.rating.toString()),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
