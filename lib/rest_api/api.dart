import 'dart:convert';

import 'package:login_page/rest_api/listings.dart';
import 'package:login_page/rest_api/login.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/rest_api/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  String baseUrl = "http://45.9.190.78:7777/";
  Future<LoginResponse> login(LoginRequest request) async {
    final sharedPrefsTask = SharedPreferences.getInstance();
    final response =
        await http.post(baseUrl + "api/users/login/", body: request.toJson());

    print(request.toJson()); //debug
    print(baseUrl + "api/users/login/"); //debug
    if (response.statusCode == 200 || response.statusCode == 400) {
      if (response.statusCode == 200) {
        var prefs = await sharedPrefsTask;
        prefs.setString('flutterLogin', request.username);
        prefs.setString('flutterPassword', request.password);
      }
      return LoginResponse.fromJson(json.decode(response.body));
    } else
      throw Exception("Login went wrong");
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await http.post(baseUrl + "api/users/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));
    print(request.toJson());
    if (response.statusCode == 201 || response.statusCode == 400)
      return RegisterResponse.fromJson(json.decode(response.body));
    else {
      print(response.statusCode);
      throw Exception("Registration went wrong");
    }
  }

  Future<ListingsResponse> getListings({int pageNum = 1}) async {
    final page = "?page=$pageNum";
    final response = await http.get(baseUrl + "api/listings/" + page);
    if (response.statusCode == 200 || response.statusCode == 404)
      return ListingsResponse.fromJson(json.decode(response.body));
    else {
      print(response.statusCode);
      throw Exception("Listings get went wrong");
    }
  }
}
