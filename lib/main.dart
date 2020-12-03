import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/common_elements/globals.dart';
import 'package:login_page/common_elements/text_elements.dart';
import 'package:login_page/logout_page.dart';
import 'package:login_page/main4screen.dart';
import 'package:login_page/page_templates.dart';
import 'package:login_page/rest_api/api.dart';
import 'package:login_page/rest_api/login.dart';
import 'package:login_page/sign_up.dart';
import 'package:login_page/common_elements/text_fields.dart';
import 'common_elements/buttons.dart';
import 'common_elements/globals.dart' as globals;

Future<void> initCache() async {
  var prefs = globals.prefs = await globals.sharedPreferencesTask;
  if (prefs.containsKey('flutterLogin') &&
      prefs.containsKey('flutterPassword')) {
    var request = LoginRequest(
        username: prefs.getString('flutterLogin'),
        password: prefs.getString('flutterPassword'));
    var response = await API().login(request);
    if (response.token.isNotEmpty) {
      globals.token = "Token " + response.token;
      loggedIn = true;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initCache();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Color(0xffDBB3B1),
          fontFamily: 'Lato',
        ),
        home: loggedIn ? MainScreens() : LoginPage(),
        routes: {
          "/profile": (_) => MainScreens(),
          "/logout": (_) => LogoutPage(),
          "/login": (_) => LoginPage(),
        });
  }
}

class LoginPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  LoginPage({this.scaffoldKey});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  LoginRequest loginRequest;

  @override
  void initState() {
    super.initState();
    loginRequest = new LoginRequest();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: Column(
        children: <Widget>[
          Center(heightFactor: 4, child: TextPrimary(text: "Welcome")),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                PrimaryTextField(
                  onSaved: (input) => loginRequest.username = input,
                  labelText: "e-mail",
                  preIcon: Icons.mail_outline,
                  validator: (value) {
                    return validateLogin(value);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                PrimaryTextField(
                  onSaved: (input) => loginRequest.password = input,
                  labelText: "password",
                  preIcon: Icons.vpn_key_outlined,
                  obscure: true,
                  validator: (value) {
                    if (value.isEmpty)
                      return "The Login/Password pair doesn't exist";
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          PrimaryButton("Login", successfulLogin),
          SizedBox(height: 5),
          Center(
            child: Text("- OR -"),
          ),
          SizedBox(height: 5),
          PrimaryButton(
              "Sign up", BasicPage.switchPage, [context, SignUpPage()]),
          SizedBox(height: 15),
          SecondaryButton("Forgot password?", (context) {}),
        ],
      ),
    );
  }

  void signUpFunc(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void successfulLogin() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Fluttertoast.showToast(
          msg: "Processing...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Color(0xffA67F8E),
          textColor: Color(0xff2C1A1D),
          fontSize: 25.0);
      new API().login(loginRequest).then((value) {
        if (value.token.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Login successful!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Color(0xffA67F8E),
              textColor: Color(0xff2C1A1D),
              fontSize: 25.0);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreens()));
        }
      });
    }
  }
}

String validateLogin(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) return "Please enter a valid e-mail";
  return null;
}

String validatePassword(String pass, [String confirm]) {
  bool passValid =
      RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
          .hasMatch(pass);
  if (!passValid) return "The password doesn't meet the security requirements";
  if (confirm != null) {
    bool passConfirmed = pass == confirm;
    if (!passConfirmed) return "Passwords do not match";
  }

  return null;
}
