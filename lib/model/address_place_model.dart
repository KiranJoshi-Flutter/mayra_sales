// To parse this JSON data, do
//
//     final addressPlaceModel = addressPlaceModelFromJson(jsonString);

import 'dart:convert';

List<AddressPlaceModel> addressPlaceModelFromJson(String str) =>
    List<AddressPlaceModel>.from(
        json.decode(str).map((x) => AddressPlaceModel.fromJson(x)));

String addressPlaceModelToJson(List<AddressPlaceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressPlaceModel {
  AddressPlaceModel({
    this.name,
    this.districts,
  });

  String name;
  List<District> districts;

  factory AddressPlaceModel.fromJson(Map<String, dynamic> json) =>
      AddressPlaceModel(
        name: json["name"] == null ? null : json["name"],
        districts: json["districts"] == null
            ? null
            : List<District>.from(
                json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "districts": districts == null
            ? null
            : List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.province,
    this.district,
    this.cities,
  });

  String province;
  String district;
  List<String> cities;

  factory District.fromJson(Map<String, dynamic> json) => District(
        province: json["province"] == null ? null : json["province"],
        district: json["district"] == null ? null : json["district"],
        cities: json["cities"] == null
            ? null
            : List<String>.from(json["cities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "province": province == null ? null : province,
        "district": district == null ? null : district,
        "cities":
            cities == null ? null : List<dynamic>.from(cities.map((x) => x)),
      };
}
