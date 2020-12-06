import 'package:json_annotation/json_annotation.dart';
import 'package:login_page/rest_api/profile.dart';

part 'register.g.dart';

class RegisterRequest {
  String email;
  String password;

  RegisterRequest({this.email, this.password});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim(),
    };

    return map;
  }
}

@JsonSerializable(explicitToJson: true)
class RegisterResponse {
  final String email;
  final bool is_email_verified;
  final DateTime date_joined;
  final int balance;
  final String error;
  final ProfileInfo profile;

  RegisterResponse(
      {this.email,
      this.is_email_verified,
      this.date_joined,
      this.balance,
      this.error,
      this.profile});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
