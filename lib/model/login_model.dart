// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.data,
  });

  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.token,
    this.name,
  });

  String token;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? null : json["token"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "name": name == null ? null : name,
      };
}
