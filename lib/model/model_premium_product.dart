// To parse this JSON data, do
//
//     final premiumProductModel = premiumProductModelFromJson(jsonString);

import 'dart:convert';

PremiumProductModel premiumProductModelFromJson(String str) =>
    PremiumProductModel.fromJson(json.decode(str));

String premiumProductModelToJson(PremiumProductModel data) =>
    json.encode(data.toJson());

class PremiumProductModel {
  PremiumProductModel({
    this.status,
    this.details,
  });

  String status;
  List<Detail> details;

  factory PremiumProductModel.fromJson(Map<String, dynamic> json) =>
      PremiumProductModel(
        status: json["status"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.id,
    this.sku,
    this.productType,
    this.affiliateLink,
    this.userId,
    this.categoryId,
    this.subcategoryId,
    this.childcategoryId,
    this.attributes,
    this.name,
    this.slug,
    this.photo,
    this.thumbnail,
    this.file,
    this.size,
    this.sizeQty,
    this.sizePrice,
    this.color,
    this.price,
    this.previousPrice,
    this.details,
    this.stock,
    this.policy,
    this.status,
    this.views,
    this.tags,
    this.features,
    this.colors,
    this.productCondition,
    this.ship,
    this.isMeta,
    this.metaTag,
    this.metaDescription,
    this.youtube,
    this.type,
    this.license,
    this.licenseQty,
    this.link,
    this.platform,
    this.region,
    this.licenceType,
    this.measure,
    this.featured,
    this.best,
    this.top,
    this.hot,
    this.latest,
    this.big,
    this.trending,
    this.sale,
    this.createdAt,
    this.updatedAt,
    this.isDiscount,
    this.discountDate,
    this.wholeSellQty,
    this.wholeSellDiscount,
    this.isCatalog,
    this.catalogId,
  });

  int id;
  String sku;
  String productType;
  dynamic affiliateLink;
  int userId;
  int categoryId;
  int subcategoryId;
  int childcategoryId;
  dynamic attributes;
  String name;
  String slug;
  String photo;
  String thumbnail;
  dynamic file;
  String size;
  String sizeQty;
  String sizePrice;
  String color;
  int price;
  int previousPrice;
  String details;
  dynamic stock;
  String policy;
  int status;
  int views;
  String tags;
  String features;
  String colors;
  int productCondition;
  dynamic ship;
  int isMeta;
  String metaTag;
  dynamic metaDescription;
  dynamic youtube;
  String type;
  String license;
  String licenseQty;
  dynamic link;
  dynamic platform;
  dynamic region;
  dynamic licenceType;
  dynamic measure;
  int featured;
  int best;
  int top;
  int hot;
  int latest;
  int big;
  int trending;
  int sale;
  DateTime createdAt;
  DateTime updatedAt;
  int isDiscount;
  dynamic discountDate;
  String wholeSellQty;
  String wholeSellDiscount;
  int isCatalog;
  int catalogId;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        sku: json["sku"],
        productType: json["product_type"],
        affiliateLink: json["affiliate_link"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        subcategoryId:
            json["subcategory_id"] == null ? null : json["subcategory_id"],
        childcategoryId:
            json["childcategory_id"] == null ? null : json["childcategory_id"],
        attributes: json["attributes"],
        name: json["name"],
        slug: json["slug"],
        photo: json["photo"],
        thumbnail: json["thumbnail"],
        file: json["file"],
        size: json["size"],
        sizeQty: json["size_qty"],
        sizePrice: json["size_price"],
        color: json["color"],
        price: json["price"],
        previousPrice: json["previous_price"],
        details: json["details"],
        stock: json["stock"],
        policy: json["policy"],
        status: json["status"],
        views: json["views"],
        tags: json["tags"],
        features: json["features"],
        colors: json["colors"],
        productCondition: json["product_condition"],
        ship: json["ship"],
        isMeta: json["is_meta"],
        metaTag: json["meta_tag"],
        metaDescription: json["meta_description"],
        youtube: json["youtube"],
        type: json["type"],
        license: json["license"],
        licenseQty: json["license_qty"],
        link: json["link"],
        platform: json["platform"],
        region: json["region"],
        licenceType: json["licence_type"],
        measure: json["measure"],
        featured: json["featured"],
        best: json["best"],
        top: json["top"],
        hot: json["hot"],
        latest: json["latest"],
        big: json["big"],
        trending: json["trending"],
        sale: json["sale"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isDiscount: json["is_discount"],
        discountDate: json["discount_date"],
        wholeSellQty: json["whole_sell_qty"],
        wholeSellDiscount: json["whole_sell_discount"],
        isCatalog: json["is_catalog"],
        catalogId: json["catalog_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "product_type": productType,
        "affiliate_link": affiliateLink,
        "user_id": userId,
        "category_id": categoryId,
        "subcategory_id": subcategoryId == null ? null : subcategoryId,
        "childcategory_id": childcategoryId == null ? null : childcategoryId,
        "attributes": attributes,
        "name": name,
        "slug": slug,
        "photo": photo,
        "thumbnail": thumbnail,
        "file": file,
        "size": size,
        "size_qty": sizeQty,
        "size_price": sizePrice,
        "color": color,
        "price": price,
        "previous_price": previousPrice,
        "details": details,
        "stock": stock,
        "policy": policy,
        "status": status,
        "views": views,
        "tags": tags,
        "features": features,
        "colors": colors,
        "product_condition": productCondition,
        "ship": ship,
        "is_meta": isMeta,
        "meta_tag": metaTag,
        "meta_description": metaDescription,
        "youtube": youtube,
        "type": type,
        "license": license,
        "license_qty": licenseQty,
        "link": link,
        "platform": platform,
        "region": region,
        "licence_type": licenceType,
        "measure": measure,
        "featured": featured,
        "best": best,
        "top": top,
        "hot": hot,
        "latest": latest,
        "big": big,
        "trending": trending,
        "sale": sale,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_discount": isDiscount,
        "discount_date": discountDate,
        "whole_sell_qty": wholeSellQty,
        "whole_sell_discount": wholeSellDiscount,
        "is_catalog": isCatalog,
        "catalog_id": catalogId,
      };
}
