import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login_page/common_elements/buttons.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      SizedBox(height: 30),
      Image.asset("lib/pics/profile.png", width: 250, height: 250),
      Row(
        children: [
          Expanded(
              child: PrimaryTextField(
            labelText: "Name",
          )),
          Expanded(child: PrimaryTextField(labelText: "Surname"))
        ],
      ),
      IntlPhoneField(
        decoration: InputDecoration(
          labelText: "Phone number",
          labelStyle: TextStyle(fontSize: 25, color: Color(0xff2C1A1D)),
        ),
        initialCountryCode: "RU",
      ),
      PrimaryTextField(
          labelText: "Address", preIcon: Icons.location_on_outlined),
      PrimaryTextField(labelText: "About"),
      SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SecondaryButton("Edit profile", (context) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileEditPage()));
          }),
          SizedBox(width: 15),
          SecondaryButton("Exit", (context) {
            globals.prefs.remove('flutterLogin');
            globals.prefs.remove('flutterPassword');

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }),
        ],
      ),
    ]));
  }
}
