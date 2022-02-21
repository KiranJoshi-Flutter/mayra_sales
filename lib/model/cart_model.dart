// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.status,
    this.details,
  });

  String status;
  List<Detail> details;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
    this.userId,
    this.qty,
    this.sizeKey,
    this.sizeQty,
    this.sizePrice,
    this.size,
    this.color,
    this.stock,
    this.price,
    this.productId,
    this.license,
    this.dp,
    this.sku,
    this.productType,
    this.affiliateLink,
    this.categoryId,
    this.subcategoryId,
    this.childcategoryId,
    this.attributes,
    this.name,
    this.slug,
    this.photo,
    this.thumbnail,
    this.file,
    this.previousPrice,
    this.details,
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
  int userId;
  int qty;
  dynamic sizeKey;
  dynamic sizeQty;
  dynamic sizePrice;
  dynamic size;
  dynamic color;
  dynamic stock;
  int price;
  int productId;
  dynamic license;
  dynamic dp;
  String sku;
  String productType;
  dynamic affiliateLink;
  int categoryId;
  dynamic subcategoryId;
  dynamic childcategoryId;
  dynamic attributes;
  String name;
  String slug;
  String photo;
  String thumbnail;
  dynamic file;
  int previousPrice;
  String details;
  String policy;
  int status;
  int views;
  dynamic tags;
  dynamic features;
  dynamic colors;
  int productCondition;
  dynamic ship;
  int isMeta;
  dynamic metaTag;
  dynamic metaDescription;
  dynamic youtube;
  String type;
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

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        qty: json["qty"],
        sizeKey: json["size_key"],
        sizeQty: json["size_qty"],
        sizePrice: json["size_price"],
        size: json["size"],
        color: json["color"],
        stock: json["stock"],
        price: json["price"] == null ? null : json["price"],
        productId: json["product_id"],
        license: json["license"],
        dp: json["dp"],
        sku: json["sku"] == null ? null : json["sku"],
        productType: json["product_type"] == null ? null : json["product_type"],
        affiliateLink: json["affiliate_link"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        subcategoryId: json["subcategory_id"],
        childcategoryId: json["childcategory_id"],
        attributes: json["attributes"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        photo: json["photo"] == null ? null : json["photo"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        file: json["file"],
        previousPrice:
            json["previous_price"] == null ? null : json["previous_price"],
        details: json["details"] == null ? null : json["details"],
        policy: json["policy"] == null ? null : json["policy"],
        status: json["status"] == null ? null : json["status"],
        views: json["views"] == null ? null : json["views"],
        tags: json["tags"],
        features: json["features"],
        colors: json["colors"],
        productCondition: json["product_condition"] == null
            ? null
            : json["product_condition"],
        ship: json["ship"],
        isMeta: json["is_meta"] == null ? null : json["is_meta"],
        metaTag: json["meta_tag"],
        metaDescription: json["meta_description"],
        youtube: json["youtube"],
        type: json["type"] == null ? null : json["type"],
        licenseQty: json["license_qty"],
        link: json["link"],
        platform: json["platform"],
        region: json["region"],
        licenceType: json["licence_type"],
        measure: json["measure"],
        featured: json["featured"] == null ? null : json["featured"],
        best: json["best"] == null ? null : json["best"],
        top: json["top"] == null ? null : json["top"],
        hot: json["hot"] == null ? null : json["hot"],
        latest: json["latest"] == null ? null : json["latest"],
        big: json["big"] == null ? null : json["big"],
        trending: json["trending"] == null ? null : json["trending"],
        sale: json["sale"] == null ? null : json["sale"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDiscount: json["is_discount"] == null ? null : json["is_discount"],
        discountDate: json["discount_date"],
        wholeSellQty: json["whole_sell_qty"],
        wholeSellDiscount: json["whole_sell_discount"],
        isCatalog: json["is_catalog"] == null ? null : json["is_catalog"],
        catalogId: json["catalog_id"] == null ? null : json["catalog_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "qty": qty,
        "size_key": sizeKey,
        "size_qty": sizeQty,
        "size_price": sizePrice,
        "size": size,
        "color": color,
        "stock": stock,
        "price": price == null ? null : price,
        "product_id": productId,
        "license": license,
        "dp": dp,
        "sku": sku == null ? null : sku,
        "product_type": productType == null ? null : productType,
        "affiliate_link": affiliateLink,
        "category_id": categoryId == null ? null : categoryId,
        "subcategory_id": subcategoryId,
        "childcategory_id": childcategoryId,
        "attributes": attributes,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "photo": photo == null ? null : photo,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "file": file,
        "previous_price": previousPrice == null ? null : previousPrice,
        "details": details == null ? null : details,
        "policy": policy == null ? null : policy,
        "status": status == null ? null : status,
        "views": views == null ? null : views,
        "tags": tags,
        "features": features,
        "colors": colors,
        "product_condition": productCondition == null ? null : productCondition,
        "ship": ship,
        "is_meta": isMeta == null ? null : isMeta,
        "meta_tag": metaTag,
        "meta_description": metaDescription,
        "youtube": youtube,
        "type": type == null ? null : type,
        "license_qty": licenseQty,
        "link": link,
        "platform": platform,
        "region": region,
        "licence_type": licenceType,
        "measure": measure,
        "featured": featured == null ? null : featured,
        "best": best == null ? null : best,
        "top": top == null ? null : top,
        "hot": hot == null ? null : hot,
        "latest": latest == null ? null : latest,
        "big": big == null ? null : big,
        "trending": trending == null ? null : trending,
        "sale": sale == null ? null : sale,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "is_discount": isDiscount == null ? null : isDiscount,
        "discount_date": discountDate,
        "whole_sell_qty": wholeSellQty,
        "whole_sell_discount": wholeSellDiscount,
        "is_catalog": isCatalog == null ? null : isCatalog,
        "catalog_id": catalogId == null ? null : catalogId,
      };
}
