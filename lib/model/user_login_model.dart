// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) =>
    UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserLoginModel({
    this.status,
    this.details,
    this.userType,
    this.token,
  });

  String status;
  String details;
  String userType;
  String token;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        status: json["status"],
        details: json["details"],
        userType: json["user_type"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "details": details,
        "user_type": userType,
        "token": token,
      };
}
