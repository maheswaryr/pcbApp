import 'dart:convert';

// ignore: non_constant_identifier_names
LoginResponse LoginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String? LoginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.token,
  });

  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
