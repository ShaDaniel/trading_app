import 'dart:convert';

import 'package:login_page/rest_api/listing_create.dart';
import 'package:login_page/rest_api/listings.dart';
import 'package:login_page/rest_api/login.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/rest_api/profile.dart';
import 'package:login_page/rest_api/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_page/common_elements/globals.dart' as globals;

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

  Future<Listing> listingCreate(ListingRequest request) async {
    final response = await http.post(baseUrl + "api/listings/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.token
        },
        body: jsonEncode(request.toJson()));
    print(response.body); //debug
    if (response.statusCode == 201 || response.statusCode == 400)
      return Listing.fromJson(json.decode(response.body));
    else {
      print(response.statusCode);
      throw Exception("Listing create went wrong");
    }
  }

  Future<RegisterResponse> getUserAndProfile() async {
    final response = await http.get(baseUrl + "api/users/",
        headers: <String, String>{'Authorization': globals.token});
    if (response.statusCode == 200 || response.statusCode == 400)
      return RegisterResponse.fromJson(json.decode(response.body));
    else {
      print(response.statusCode);
      throw Exception("Get user and profile went wrong");
    }
  }

  Future<ProfileInfo> updateProfile(ProfileInfo request) async {
    final response = await http.patch(baseUrl + "api/profiles/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.token
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ProfileInfo.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw Exception("Profile update went wrong");
    }
  }
}
