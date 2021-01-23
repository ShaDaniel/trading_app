import 'package:flutter/material.dart';
import 'package:login_page/common_elements/fluttertoast.dart';
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
import 'common_elements/colors.dart' as colors;
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';

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

    await initBasicInfo();
  }
}

Future<void> initBasicInfo() async {
  globals.userInfo = await API().getUserAndProfile();
}

Future getUserLocation() async {
  location.Location loc = location.Location();
  location.LocationData currentLocation;
  bool _serviceEnabled;
  location.PermissionStatus _permissionGranted;

  _serviceEnabled = await loc.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await loc.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await loc.hasPermission();
  if (_permissionGranted == location.PermissionStatus.denied) {
    _permissionGranted = await loc.requestPermission();
    if (_permissionGranted != location.PermissionStatus.granted) {
      return;
    }
  }
  try {
    currentLocation = await loc.getLocation();
    print(currentLocation.latitude);
    print(currentLocation.longitude);
  } catch (e) {
    print(e);
    currentLocation = null;
  }
  globals.userLocation = currentLocation;
  if (currentLocation != null) getAddressFromCoords(currentLocation);
}

void getAddressFromCoords(location.LocationData coords) async {
  var address = await new API().getAddressFromCoords(coords);
  globals.userLocationAddress = address;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initCache();
  await getUserLocation();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: colors.accent,
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

      showToast("Processing...");

      new API().login(loginRequest).then((value) {
        if (value.token.isNotEmpty) {
          globals.token = "Token " + value.token;
          loggedIn = true;
          initBasicInfo();
        }
        if (value.token.isNotEmpty) {
          showToast("Login successful!");
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
