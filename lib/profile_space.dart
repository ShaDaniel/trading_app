import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login_page/common_elements/buttons.dart';
import 'package:login_page/feed.dart';
import 'package:login_page/main.dart';
import 'package:login_page/main4screen.dart';
import 'package:login_page/common_elements/text_fields.dart';
import 'package:login_page/profile_edit.dart';
import 'package:login_page/rest_api/api.dart';
import 'package:login_page/rest_api/register.dart';
import 'common_elements/globals.dart' as globals;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  RegisterResponse userInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().getUserAndProfile(),
        builder:
            (BuildContext context, AsyncSnapshot<RegisterResponse> response) {
          if (response.connectionState != ConnectionState.done) {
            print("not done yet");
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Color(0xff2C1A1D),
            ));
          } else {
            userInfo = response.data;
            return SingleChildScrollView(
                child: Container(
                    child: Column(children: <Widget>[
              SizedBox(height: 30),
              Image.asset("lib/pics/profile.png", width: 250, height: 250),
              Row(
                children: [
                  Expanded(
                      child: PrimaryTextField(
                    labelText: "Name",
                    initialValue: userInfo.profile.full_name,
                    readOnly: true,
                  )),
                  Expanded(
                      child: PrimaryTextField(
                    labelText: "Surname",
                    readOnly: true,
                  ))
                ],
              ),
              IntlPhoneField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Phone number",
                  labelStyle: TextStyle(fontSize: 25, color: Color(0xff2C1A1D)),
                ),
                initialCountryCode: "RU",
              ),
              PrimaryTextField(
                labelText: "Address",
                preIcon: Icons.location_on_outlined,
                readOnly: true,
              ),
              PrimaryTextField(
                labelText: "About",
                readOnly: true,
                initialValue: userInfo.profile.about,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SecondaryButton("Edit profile", (context) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileEditPage()));
                  }),
                  SizedBox(width: 15),
                  SecondaryButton("Exit", (context) {
                    globals.prefs.remove('flutterLogin');
                    globals.prefs.remove('flutterPassword');

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }),
                ],
              ),
              SizedBox(height: 15),
              Container(
                  height: 450,
                  child: FeedList(
                      filter: userInfo.profile.uuid,
                      filterCode: Filters.PersonUuid.index)),
              SizedBox(height: 15),
            ])));
          }
        });
  }
}
