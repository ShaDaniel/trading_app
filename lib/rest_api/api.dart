import 'dart:convert';

import 'package:location/location.dart';
import 'package:login_page/rest_api/listing_create.dart';
import 'package:login_page/rest_api/listings.dart';
import 'package:login_page/rest_api/login.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/rest_api/profile.dart';
import 'package:login_page/rest_api/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_page/common_elements/globals.dart' as globals;

class API {
  // Приватных адресов в коде, тем более в публичном репозитории, быть не должно.
  String baseUrl = "http://45.9.190.78:7777/";

  Future<LoginResponse> login(LoginRequest request) async {
    final sharedPrefsTask = SharedPreferences.getInstance();
    final response =
        await http.post(baseUrl + "api/users/login/", body: request.toJson());

    // Лол, дебаг. Принты в коде оставлять нельзя.
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

  Future<String> getAddressFromCoords(LocationData coords) async {
    // Ты запушил код с приватным токеном, и это пиздец. Понятно, этот конкретный
    // ничего не стоит, но нельзя даже думать, чтобы вставить такое прямо в код.
    var apiKey = "8MR1Km-kluRtgoCtuiCOEnSqI5WAhGVpbaMc0o5xEf4";
    // Такие урлы в общем тоже в конфиг-файле должны лежать.
    var url =
        "https://revgeocode.search.hereapi.com/v1/revgeocode?at=${coords.latitude},${coords.longitude}&lang=ru-RU&apiKey=${apiKey}";
    print(url);

    final response = await http.get(url);
    var info = json.decode(utf8.decode(response.bodyBytes));
    print(info);

    if (response.statusCode == 200 || response.statusCode == 400) {
      // Nested ternary: grade -42
      return "${info["items"][0]["address"]["city"]}" == "null"
          ? ""
          : "${info["items"][0]["address"]["city"]}" +
              ("${info["items"][0]["address"]["street"]}" == "null"
                  ? ""
                  : ", ${info["items"][0]["address"]["street"]}") +
              ("${info["items"][0]["address"]["houseNumber"]}" == "null"
                  ? ""
                  : ", ${info["items"][0]["address"]["houseNumber"]}");
      // Неужели это лучше, чем:
      var city = info["items"][0]["address"]["city"];
      if (city == "null") return "";
      var street = info["items"][0]["address"]["street"];
      if (street == "null") return "$city";
      var houseNumber = info["items"][0]["address"]["houseNumber"];
      if (houseNumber == "null") return "$city, $street";
      return "$city, $street, $houseNumber";
      //
    } else
      throw Exception("Address fetch from Here.com went wrong");
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await http.post(baseUrl + "api/users/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));
    print(request.toJson());
    if (response.statusCode == 201) {
      print(response.body);
      return RegisterResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400)
      return null;
    else {
      print(response.statusCode);
      throw Exception("Registration went wrong");
    }
  }

  Future<ListingsResponse> getListings({int pageNum = 1}) async {
    final page = "?page=$pageNum";
    final response = await http.get(baseUrl + "api/listings/" + page);
    if (response.statusCode == 200 || response.statusCode == 404)
      return ListingsResponse.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
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
      return Listing.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    else {
      print(response.statusCode);
      throw Exception("Listing create went wrong");
    }
  }

  Future<Listing> listingUpdate(ListingRequest request, String uuid) async {
    final response = await http.patch(baseUrl + "api/listings/$uuid/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.token
        },
        body: jsonEncode(request.toJson()));
    print(response.body); //debug
    if (response.statusCode == 200 || response.statusCode == 400)
      return Listing.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    else {
      print(response.statusCode);
      throw Exception("Listing update went wrong");
    }
  }

  Future<RegisterResponse> getUserAndProfile() async {
    final response = await http.get(baseUrl + "api/users/",
        headers: <String, String>{'Authorization': globals.token});
    if (response.statusCode == 200 || response.statusCode == 400) {
      globals.userInfo = RegisterResponse.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return globals.userInfo;
    } else {
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

  Future<Map<String, dynamic>> getCategoriesGoods() async {
    final response = await http.get(baseUrl + "api/info/");
    if (response.statusCode == 200)
      return json.decode(utf8.decode(response.bodyBytes));
    else
      throw Exception("Categories goods fetch went wrong");
  }
}
