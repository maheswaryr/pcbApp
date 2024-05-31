import 'dart:convert';

// ignore: non_constant_identifier_names
LoginRequest LoginRequestFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String LoginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    this.domain,
    this.username,
    this.password,
  });

  String? domain;
  String? username;
  String? password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        domain: json["domain"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "domain": domain,
        "username": username,
        "password": password,
      };
}
