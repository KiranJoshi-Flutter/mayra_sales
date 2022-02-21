// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(
    json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderModelToJson(List<SliderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  SliderModel({
    this.id,
    this.subtitleText,
    this.subtitleSize,
    this.subtitleColor,
    this.subtitleAnime,
    this.titleText,
    this.titleSize,
    this.titleColor,
    this.titleAnime,
    this.detailsText,
    this.detailsSize,
    this.detailsColor,
    this.detailsAnime,
    this.photo,
    this.position,
    this.link,
  });

  int id;
  String subtitleText;
  String subtitleSize;
  String subtitleColor;
  String subtitleAnime;
  String titleText;
  String titleSize;
  String titleColor;
  String titleAnime;
  String detailsText;
  String detailsSize;
  String detailsColor;
  String detailsAnime;
  String photo;
  String position;
  String link;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["id"],
        subtitleText: json["subtitle_text"],
        subtitleSize: json["subtitle_size"],
        subtitleColor: json["subtitle_color"],
        subtitleAnime: json["subtitle_anime"],
        titleText: json["title_text"],
        titleSize: json["title_size"],
        titleColor: json["title_color"],
        titleAnime: json["title_anime"],
        detailsText: json["details_text"],
        detailsSize: json["details_size"],
        detailsColor: json["details_color"],
        detailsAnime: json["details_anime"],
        photo: json["photo"],
        position: json["position"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subtitle_text": subtitleText,
        "subtitle_size": subtitleSize,
        "subtitle_color": subtitleColor,
        "subtitle_anime": subtitleAnime,
        "title_text": titleText,
        "title_size": titleSize,
        "title_color": titleColor,
        "title_anime": titleAnime,
        "details_text": detailsText,
        "details_size": detailsSize,
        "details_color": detailsColor,
        "details_anime": detailsAnime,
        "photo": photo,
        "position": position,
        "link": link,
      };
}
