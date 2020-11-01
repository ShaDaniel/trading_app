import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login_page/buttons.dart';
import 'package:login_page/main.dart';
import 'package:login_page/main4screen.dart';
import 'package:login_page/text_fields.dart';
import 'globals.dart' as globals;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MainScreens(
      child: Container(
          child: Column(children: <Widget>[
        SizedBox(height: 30),
        Image.asset("lib/pics/profile.png", width: 320, height: 320),
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
        SizedBox(height: 15),
        SecondaryButton("Exit", (context) {
          globals.prefs.remove('flutterLogin');
          globals.prefs.remove('flutterPassword');

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }),
      ])),
    );
  }
}
