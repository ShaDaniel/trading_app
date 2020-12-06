import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:login_page/common_elements/buttons.dart';
import 'package:login_page/main4screen.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/rest_api/api.dart';
import 'package:login_page/rest_api/register.dart';

import 'common_elements/text_fields.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = new GlobalKey<FormState>();
  RegisterResponse userInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().getUserAndProfile(),
        builder:
            (BuildContext context, AsyncSnapshot<RegisterResponse> response) {
          if (response.connectionState != ConnectionState.done) {
            print("not done yet");
            return BasicPage(
                child: Center(
                    child: CircularProgressIndicator(
              backgroundColor: Color(0xff2C1A1D),
            )));
          } else {
            userInfo = response.data;
            return BasicPage(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(width: 15),
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
                      SizedBox(height: 15),
                      PrimaryTextField(
                        initialValue: userInfo.profile.full_name,
                        labelText: "Fullname",
                        onSaved: (value) => userInfo.profile.full_name = value,
                      ),
                      PrimaryTextField(
                        initialValue: userInfo.profile.about,
                        labelText: "About",
                        onSaved: (value) => userInfo.profile.about = value,
                      ),
                      SizedBox(height: 15),
                      Center(
                          child: PrimaryButton("Save changes", () {
                        _formKey.currentState.save();
                        Fluttertoast.showToast(
                            msg: "Processing...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Color(0xffA67F8E),
                            textColor: Color(0xff2C1A1D),
                            fontSize: 25.0);
                        API().updateProfile(userInfo.profile).then((value) {
                          print(value.uuid);
                          if (value.uuid != null) {
                            Fluttertoast.showToast(
                                msg: "Profile update successful!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Color(0xffA67F8E),
                                textColor: Color(0xff2C1A1D),
                                fontSize: 25.0);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreens()));
                          }
                        });
                      })),
                    ],
                  )),
            );
          }
        });
  }
}
