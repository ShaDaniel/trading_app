class LoginRequest {
  String username;
  String password;

  LoginRequest({this.username, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "username": username.trim(),
      "password": password.trim(),
    };

    return map;
  }
}

class LoginResponse {
  final String token;
  final String error;

  LoginResponse({this.token, this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    print(json["token"]);
    return LoginResponse(
        token: json["token"] ?? "", error: json["error"] ?? "");
  }
}
