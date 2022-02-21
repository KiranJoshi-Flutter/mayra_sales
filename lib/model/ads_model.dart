// To parse this JSON data, do
//
//     final adsModel = adsModelFromJson(jsonString);

import 'dart:convert';

List<AdsModel> adsModelFromJson(String str) =>
    List<AdsModel>.from(json.decode(str).map((x) => AdsModel.fromJson(x)));

String adsModelToJson(List<AdsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdsModel {
  AdsModel({
    this.id,
    this.photo,
    this.link,
    this.type,
  });

  int id;
  String photo;
  String link;
  String type;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        id: json["id"],
        photo: json["photo"],
        link: json["link"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "link": link,
        "type": type,
      };
}
