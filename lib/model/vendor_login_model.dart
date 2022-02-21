// To parse this JSON data, do
//
//     final vendorLoginModel = vendorLoginModelFromJson(jsonString);

import 'dart:convert';

VendorLoginModel vendorLoginModelFromJson(String str) =>
    VendorLoginModel.fromJson(json.decode(str));

String vendorLoginModelToJson(VendorLoginModel data) =>
    json.encode(data.toJson());

class VendorLoginModel {
  VendorLoginModel({
    this.data,
  });

  Data data;

  factory VendorLoginModel.fromJson(Map<String, dynamic> json) =>
      VendorLoginModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.userType,
    this.token,
    this.name,
  });

  String userType;
  String token;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userType: json["user_type"] == null ? null : json["user_type"],
        token: json["token"] == null ? null : json["token"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "user_type": userType == null ? null : userType,
        "token": token == null ? null : token,
        "name": name == null ? null : name,
      };
}
