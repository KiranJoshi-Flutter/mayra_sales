// To parse this JSON data, do
//
//     final categoryProductModel = categoryProductModelFromJson(jsonString);

import 'dart:convert';

CategoryProductModel categoryProductModelFromJson(String str) =>
    CategoryProductModel.fromJson(json.decode(str));

String categoryProductModelToJson(CategoryProductModel data) =>
    json.encode(data.toJson());

class CategoryProductModel {
  CategoryProductModel({
    this.status,
    this.details,
  });

  String status;
  Details details;

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) =>
      CategoryProductModel(
        status: json["status"] == null ? null : json["status"],
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "details": details == null ? null : details.toJson(),
      };
}

class Details {
  Details({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Datum {
  Datum({
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
    // this.color,
    this.price,
    this.previousPrice,
    this.details,
    this.stock,
    this.policy,
    this.status,
    this.views,
    // this.tags,
    // this.features,
    // this.colors,
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
  // String color;
  int price;
  int previousPrice;
  String details;
  dynamic stock;
  dynamic policy;
  int status;
  int views;
  // String tags;
  // String features;
  // String colors;
  int productCondition;
  dynamic ship;
  int isMeta;
  String metaTag;
  dynamic metaDescription;
  dynamic youtube;
  dynamic type;
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        // color: json["color"] == null ? null : json["color"],
        price: json["price"] == null ? null : json["price"],
        previousPrice:
            json["previous_price"] == null ? null : json["previous_price"],
        details: json["details"] == null ? null : json["details"],
        stock: json["stock"],
        policy: json["policy"] == null ? null : json["policy"],
        status: json["status"] == null ? null : json["status"],
        views: json["views"] == null ? null : json["views"],
        // tags: json["tags"] == null ? null : json["tags"],
        // features: json["features"] == null ? null : json["features"],
        // colors: json["colors"] == null ? null : json["colors"],
        productCondition: json["product_condition"] == null
            ? null
            : json["product_condition"],
        ship: json["ship"],
        isMeta: json["is_meta"] == null ? null : json["is_meta"],
        metaTag: json["meta_tag"] == null ? null : json["meta_tag"],
        metaDescription: json["meta_description"],
        youtube: json["youtube"],
        type: json["type"] == null ? null : json["type"],
        license: json["license"] == null ? null : json["license"],
        licenseQty: json["license_qty"] == null ? null : json["license_qty"],
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
        wholeSellQty:
            json["whole_sell_qty"] == null ? null : json["whole_sell_qty"],
        wholeSellDiscount: json["whole_sell_discount"] == null
            ? null
            : json["whole_sell_discount"],
        isCatalog: json["is_catalog"] == null ? null : json["is_catalog"],
        catalogId: json["catalog_id"] == null ? null : json["catalog_id"],
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
        // "color": color == null ? null : color,
        "price": price == null ? null : price,
        "previous_price": previousPrice == null ? null : previousPrice,
        "details": details == null ? null : details,
        "stock": stock,
        "policy": policy == null ? null : policy,
        "status": status == null ? null : status,
        "views": views == null ? null : views,
        // "tags": tags == null ? null : tags,
        // "features": features == null ? null : features,
        // "colors": colors == null ? null : colors,
        "product_condition": productCondition == null ? null : productCondition,
        "ship": ship,
        "is_meta": isMeta == null ? null : isMeta,
        "meta_tag": metaTag == null ? null : metaTag,
        "meta_description": metaDescription,
        "youtube": youtube,
        "type": type == null ? null : type,
        "license": license == null ? null : license,
        "license_qty": licenseQty == null ? null : licenseQty,
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
        "whole_sell_qty": wholeSellQty == null ? null : wholeSellQty,
        "whole_sell_discount":
            wholeSellDiscount == null ? null : wholeSellDiscount,
        "is_catalog": isCatalog == null ? null : isCatalog,
        "catalog_id": catalogId == null ? null : catalogId,
      };
}
