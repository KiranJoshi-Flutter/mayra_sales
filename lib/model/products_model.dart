// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    this.status,
    this.details,
  });

  String status;
  List<Detail> details;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
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
    this.phone,
    this.shopName,
    this.ownerName,
    this.shopNumber,
    this.shopAddress,
    this.regNumber,
    this.shopMessage,
    this.shopDetails,
    this.shopImage,
    this.shopLocation,
  });

  int id;
  String sku;
  String productType;
  dynamic affiliateLink;
  int userId;
  int categoryId;
  dynamic subcategoryId;
  dynamic childcategoryId;
  String attributes;
  String name;
  String slug;
  String photo;
  String thumbnail;
  dynamic file;
  String size;
  String sizeQty;
  String sizePrice;
  String color;
  double price;
  int previousPrice;
  String details;
  int stock;
  String policy;
  int status;
  int views;
  dynamic tags;
  dynamic features;
  dynamic colors;
  int productCondition;
  String ship;
  int isMeta;
  dynamic metaTag;
  dynamic metaDescription;
  dynamic youtube;
  String type;
  dynamic license;
  dynamic licenseQty;
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
  dynamic wholeSellQty;
  dynamic wholeSellDiscount;
  int isCatalog;
  int catalogId;
  String phone;
  String shopName;
  String ownerName;
  String shopNumber;
  String shopAddress;
  String regNumber;
  String shopMessage;
  String shopDetails;
  dynamic shopImage;
  int shopLocation;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        sku: json["sku"],
        productType: json["product_type"],
        affiliateLink: json["affiliate_link"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        childcategoryId: json["childcategory_id"],
        attributes: json["attributes"] == null ? null : json["attributes"],
        name: json["name"],
        slug: json["slug"],
        photo: json["photo"] == null ? null : json["photo"],
        thumbnail: json["thumbnail"],
        file: json["file"],
        size: json["size"] == null ? null : json["size"],
        sizeQty: json["size_qty"] == null ? null : json["size_qty"],
        sizePrice: json["size_price"] == null ? null : json["size_price"],
        color: json["color"] == null ? null : json["color"],
        price: json["price"].toDouble(),
        previousPrice: json["previous_price"],
        details: json["details"],
        stock: json["stock"] == null ? null : json["stock"],
        policy: json["policy"],
        status: json["status"],
        views: json["views"],
        tags: json["tags"],
        features: json["features"],
        colors: json["colors"],
        productCondition: json["product_condition"],
        ship: json["ship"] == null ? null : json["ship"],
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
        phone: json["phone"] == null ? null : json["phone"],
        shopName: json["shop_name"],
        ownerName: json["owner_name"],
        shopNumber: json["shop_number"],
        shopAddress: json["shop_address"],
        regNumber: json["reg_number"] == null ? null : json["reg_number"],
        shopMessage: json["shop_message"] == null ? null : json["shop_message"],
        shopDetails: json["shop_details"] == null ? null : json["shop_details"],
        shopImage: json["shop_image"],
        shopLocation: json["shop_location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "product_type": productType,
        "affiliate_link": affiliateLink,
        "user_id": userId,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "childcategory_id": childcategoryId,
        "attributes": attributes == null ? null : attributes,
        "name": name,
        "slug": slug,
        "photo": photo == null ? null : photo,
        "thumbnail": thumbnail,
        "file": file,
        "size": size == null ? null : size,
        "size_qty": sizeQty == null ? null : sizeQty,
        "size_price": sizePrice == null ? null : sizePrice,
        "color": color == null ? null : color,
        "price": price,
        "previous_price": previousPrice,
        "details": details,
        "stock": stock == null ? null : stock,
        "policy": policy,
        "status": status,
        "views": views,
        "tags": tags,
        "features": features,
        "colors": colors,
        "product_condition": productCondition,
        "ship": ship == null ? null : ship,
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
        "phone": phone == null ? null : phone,
        "shop_name": shopName,
        "owner_name": ownerName,
        "shop_number": shopNumber,
        "shop_address": shopAddress,
        "reg_number": regNumber == null ? null : regNumber,
        "shop_message": shopMessage == null ? null : shopMessage,
        "shop_details": shopDetails == null ? null : shopDetails,
        "shop_image": shopImage,
        "shop_location": shopLocation,
      };
}
