import 'dart:convert';

UserBean userBeanFromJson(String str) => UserBean.fromJson(json.decode(str));

String userBeanToJson(UserBean data) => json.encode(data.toJson());

class UserBean {
  UserBean({
    this.userDomain,
    this.userName,
    this.password,
    this.emailId,
  });

  String? userDomain;
  String? userName;
  String? password;
  String? emailId;

  factory UserBean.fromJson(Map<String, dynamic> json) => UserBean(
        userDomain: json["userDomain"],
        userName: json["userName"],
        password: json["password"],
        emailId: json["emailId"],
      );

  Map<String, dynamic> toJson() => {
        "userDomain": userDomain,
        "userName": userName,
        "password": password,
        "emailId": emailId,
      };
}
