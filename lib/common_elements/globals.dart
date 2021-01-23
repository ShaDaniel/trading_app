library login_page.globals;

import 'package:location/location.dart';
import 'package:login_page/rest_api/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> sharedPreferencesTask =
    SharedPreferences.getInstance();
SharedPreferences prefs;
bool loggedIn = false;
String token = null;
RegisterResponse userInfo;
LocationData userLocation;
String userLocationAddress;
