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

class RegisterResponse {
  final String uuid;
  final String email;
  final bool is_email_verified;
  final DateTime date_joined;
  final int balance;
  final String error;

  RegisterResponse(
      {this.uuid,
      this.email,
      this.is_email_verified,
      this.date_joined,
      this.balance,
      this.error});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        uuid: json["uuid"] ?? "",
        email: json["email"] ?? "",
        is_email_verified: json["is_email_verified"] ?? false,
        date_joined: DateTime.parse(json["date_joined"]) ?? new DateTime(0),
        balance: json["balance"] ?? 0,
        error: json["error"] ?? "");
  }
}
