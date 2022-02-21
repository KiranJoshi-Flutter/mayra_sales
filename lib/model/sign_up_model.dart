// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.status,
    this.details,
    this.field,
    this.token,
  });

  String status;
  String details;
  String field;
  String token;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"] == null ? null : json["status"],
        details: json["details"] == null ? null : json["details"],
        field: json["field"] == null ? null : json["field"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "details": details == null ? null : details,
        "field": field == null ? null : field,
        "token": token == null ? null : token,
      };
}
