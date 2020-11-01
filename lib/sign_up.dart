import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/buttons.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/rest_api/api.dart';
import 'package:login_page/rest_api/register.dart';
import 'package:login_page/text_fields.dart';
import 'main.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  RegisterRequest registerRequest;

  @override
  void initState() {
    super.initState();
    registerRequest = new RegisterRequest();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
        child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Container(
                child: SecondaryButton("Back", (context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }, Icons.arrow_back_outlined),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
              ),
              Center(
                  heightFactor: 2,
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 50,
                        color: Color(0xff2C1A1D),
                        fontWeight: FontWeight.bold),
                  )),
              PrimaryTextField(
                onSaved: (value) => registerRequest.email = value,
                labelText: "e-mail",
                preIcon: Icons.mail_outline,
                validator: (value) {
                  return validateLogin(value);
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(children: [
                Expanded(
                  child: PrimaryTextField(
                    onSaved: (value) => registerRequest.password = value,
                    controller: _pass,
                    validator: (value) {
                      return validatePassword(value);
                    },
                    labelText: "password",
                    preIcon: Icons.vpn_key_outlined,
                    obscure: true,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg:
                            "Your password must be at least 8 characters long, be of mixed case and also contain a digit or symbol",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Color(0xffA67F8E),
                        textColor: Color(0xff2C1A1D),
                        fontSize: 16.0);
                  },
                  icon: Icon(Icons.info_outline),
                ),
              ]),
              SizedBox(
                height: 15,
              ),
              PrimaryTextField(
                controller: _confirmPass,
                validator: (value) {
                  return validatePassword(_pass.text, value);
                },
                labelText: "confirm password",
                preIcon: Icons.vpn_key_outlined,
                obscure: true,
              ),
              SizedBox(height: 40),
              PrimaryButton("Sign up", successfulSignUp),
            ],
          ),
        ],
      ),
    ));
  }

  void successfulSignUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Fluttertoast.showToast(
          msg: "Processing...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Color(0xffA67F8E),
          textColor: Color(0xff2C1A1D),
          fontSize: 25.0);
      new API().register(registerRequest).then((value) {
        if (value.uuid.isNotEmpty && value.error.isEmpty) {
          Fluttertoast.showToast(
              msg: "Registration successful!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Color(0xffA67F8E),
              textColor: Color(0xff2C1A1D),
              fontSize: 25.0);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      });
    }
  }
}
