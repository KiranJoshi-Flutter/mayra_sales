// To parse this JSON data, do
//
//     final allProductModel = allProductModelFromJson(jsonString);

import 'dart:convert';

AllProductModel allProductModelFromJson(String str) =>
    AllProductModel.fromJson(json.decode(str));

String allProductModelToJson(AllProductModel data) =>
    json.encode(data.toJson());

class AllProductModel {
  AllProductModel({
    this.status,
    this.details,
  });

  String status;
  List<Detail> details;

  factory AllProductModel.fromJson(Map<String, dynamic> json) =>
      AllProductModel(
        status: json["status"] == null ? null : json["status"],
        details: json["details"] == null
            ? null
            : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "details": details == null
            ? null
            : List<dynamic>.from(details.map((x) => x.toJson())),
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
    this.vendorName,
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
    this.subsId,
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
  int stock;
  String policy;
  int status;
  int views;
  String tags;
  String features;
  String colors;
  int productCondition;
  String ship;
  int isMeta;
  String metaTag;
  dynamic metaDescription;
  String youtube;
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
  String discountDate;
  String wholeSellQty;
  String wholeSellDiscount;
  int isCatalog;
  int catalogId;
  String vendorName;
  String phone;
  String shopName;
  String ownerName;
  String shopNumber;
  String shopAddress;
  String regNumber;
  String shopMessage;
  String shopDetails;
  String shopImage;
  int shopLocation;
  int subsId;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"] == null ? null : json["id"],
        sku: json["sku"] == null ? null : json["sku"],
        productType: json["product_type"] == null ? null : json["product_type"],
        affiliateLink: json["affiliate_link"],
        userId: json["user_id"] == null ? null : json["user_id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        subcategoryId:
            json["subcategory_id"] == null ? null : json["subcategory_id"],
        childcategoryId:
            json["childcategory_id"] == null ? null : json["childcategory_id"],
        attributes: json["attributes"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        photo: json["photo"] == null ? null : json["photo"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        file: json["file"],
        size: json["size"] == null ? null : json["size"],
        sizeQty: json["size_qty"] == null ? null : json["size_qty"],
        sizePrice: json["size_price"] == null ? null : json["size_price"],
        color: json["color"] == null ? null : json["color"],
        price: json["price"] == null ? null : json["price"],
        previousPrice:
            json["previous_price"] == null ? null : json["previous_price"],
        details: json["details"] == null ? null : json["details"],
        stock: json["stock"] == null ? null : json["stock"],
        policy: json["policy"] == null ? null : json["policy"],
        status: json["status"] == null ? null : json["status"],
        views: json["views"] == null ? null : json["views"],
        tags: json["tags"] == null ? null : json["tags"],
        features: json["features"] == null ? null : json["features"],
        colors: json["colors"] == null ? null : json["colors"],
        productCondition: json["product_condition"] == null
            ? null
            : json["product_condition"],
        ship: json["ship"] == null ? null : json["ship"],
        isMeta: json["is_meta"] == null ? null : json["is_meta"],
        metaTag: json["meta_tag"] == null ? null : json["meta_tag"],
        metaDescription: json["meta_description"],
        youtube: json["youtube"] == null ? null : json["youtube"],
        type: json["type"] == null ? null : json["type"],
        license: json["license"],
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
        discountDate:
            json["discount_date"] == null ? null : json["discount_date"],
        wholeSellQty:
            json["whole_sell_qty"] == null ? null : json["whole_sell_qty"],
        wholeSellDiscount: json["whole_sell_discount"] == null
            ? null
            : json["whole_sell_discount"],
        isCatalog: json["is_catalog"] == null ? null : json["is_catalog"],
        catalogId: json["catalog_id"] == null ? null : json["catalog_id"],
        vendorName: json["vendor_name"] == null ? null : json["vendor_name"],
        phone: json["phone"] == null ? null : json["phone"],
        shopName: json["shop_name"] == null ? null : json["shop_name"],
        ownerName: json["owner_name"] == null ? null : json["owner_name"],
        shopNumber: json["shop_number"] == null ? null : json["shop_number"],
        shopAddress: json["shop_address"] == null ? null : json["shop_address"],
        regNumber: json["reg_number"] == null ? null : json["reg_number"],
        shopMessage: json["shop_message"] == null ? null : json["shop_message"],
        shopDetails: json["shop_details"] == null ? null : json["shop_details"],
        shopImage: json["shop_image"] == null ? null : json["shop_image"],
        shopLocation:
            json["shop_location"] == null ? null : json["shop_location"],
        subsId: json["subs_id"] == null ? null : json["subs_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "sku": sku == null ? null : sku,
        "product_type": productType == null ? null : productType,
        "affiliate_link": affiliateLink,
        "user_id": userId == null ? null : userId,
        "category_id": categoryId == null ? null : categoryId,
        "subcategory_id": subcategoryId == null ? null : subcategoryId,
        "childcategory_id": childcategoryId == null ? null : childcategoryId,
        "attributes": attributes,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "photo": photo == null ? null : photo,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "file": file,
        "size": size == null ? null : size,
        "size_qty": sizeQty == null ? null : sizeQty,
        "size_price": sizePrice == null ? null : sizePrice,
        "color": color == null ? null : color,
        "price": price == null ? null : price,
        "previous_price": previousPrice == null ? null : previousPrice,
        "details": details == null ? null : details,
        "stock": stock == null ? null : stock,
        "policy": policy == null ? null : policy,
        "status": status == null ? null : status,
        "views": views == null ? null : views,
        "tags": tags == null ? null : tags,
        "features": features == null ? null : features,
        "colors": colors == null ? null : colors,
        "product_condition": productCondition == null ? null : productCondition,
        "ship": ship == null ? null : ship,
        "is_meta": isMeta == null ? null : isMeta,
        "meta_tag": metaTag == null ? null : metaTag,
        "meta_description": metaDescription,
        "youtube": youtube == null ? null : youtube,
        "type": type == null ? null : type,
        "license": license,
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
        "discount_date": discountDate == null ? null : discountDate,
        "whole_sell_qty": wholeSellQty == null ? null : wholeSellQty,
        "whole_sell_discount":
            wholeSellDiscount == null ? null : wholeSellDiscount,
        "is_catalog": isCatalog == null ? null : isCatalog,
        "catalog_id": catalogId == null ? null : catalogId,
        "vendor_name": vendorName == null ? null : vendorName,
        "phone": phone == null ? null : phone,
        "shop_name": shopName == null ? null : shopName,
        "owner_name": ownerName == null ? null : ownerName,
        "shop_number": shopNumber == null ? null : shopNumber,
        "shop_address": shopAddress == null ? null : shopAddress,
        "reg_number": regNumber == null ? null : regNumber,
        "shop_message": shopMessage == null ? null : shopMessage,
        "shop_details": shopDetails == null ? null : shopDetails,
        "shop_image": shopImage == null ? null : shopImage,
        "shop_location": shopLocation == null ? null : shopLocation,
        "subs_id": subsId == null ? null : subsId,
      };
}
