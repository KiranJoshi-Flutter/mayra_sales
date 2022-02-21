// To parse this JSON data, do
//
//     final imageUpdateModel = imageUpdateModelFromJson(jsonString);

import 'dart:convert';

ImageUpdateModel imageUpdateModelFromJson(String str) =>
    ImageUpdateModel.fromJson(json.decode(str));

String imageUpdateModelToJson(ImageUpdateModel data) =>
    json.encode(data.toJson());

class ImageUpdateModel {
  ImageUpdateModel({
    this.status,
    this.details,
    this.image,
  });

  String status;
  String details;
  String image;

  factory ImageUpdateModel.fromJson(Map<String, dynamic> json) =>
      ImageUpdateModel(
        status: json["status"],
        details: json["details"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "details": details,
        "image": image,
      };
}
