library login_page.globals;

import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> sharedPreferencesTask =
    SharedPreferences.getInstance();
SharedPreferences prefs;
bool loggedIn = false;
String token = null;
