// To parse this JSON data, do
//
//     final homeScreenModel = homeScreenModelFromJson(jsonString);

import 'dart:convert';

HomeScreenModel homeScreenModelFromJson(String str) =>
    HomeScreenModel.fromJson(json.decode(str));

String homeScreenModelToJson(HomeScreenModel data) =>
    json.encode(data.toJson());

class HomeScreenModel {
  HomeScreenModel({
    this.homeScreen,
  });

  HomeScreen homeScreen;

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenModel(
        homeScreen: json["home_screen"] == null
            ? null
            : HomeScreen.fromJson(json["home_screen"]),
      );

  Map<String, dynamic> toJson() => {
        "home_screen": homeScreen == null ? null : homeScreen.toJson(),
      };
}

class HomeScreen {
  HomeScreen({
    this.sliders,
    this.ads,
    this.premiumProducts,
    this.bigsaveProducts,
    this.hotProducts,
    this.latestProducts,
    this.trendingProducts,
    this.saleProducts,
    this.bestsaleProducts,
    this.flashdealProducts,
  });

  List<Slider> sliders;
  List<Ad> ads;
  List<Product> premiumProducts;
  List<Product> bigsaveProducts;
  List<dynamic> hotProducts;
  List<LatestProduct> latestProducts;
  List<dynamic> trendingProducts;
  List<dynamic> saleProducts;
  List<dynamic> bestsaleProducts;
  List<dynamic> flashdealProducts;

  factory HomeScreen.fromJson(Map<String, dynamic> json) => HomeScreen(
        sliders: json["sliders"] == null
            ? null
            : List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
        ads: json["ads"] == null
            ? null
            : List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
        premiumProducts: json["premium_products"] == null
            ? null
            : List<Product>.from(
                json["premium_products"].map((x) => Product.fromJson(x))),
        bigsaveProducts: json["bigsave_products"] == null
            ? null
            : List<Product>.from(
                json["bigsave_products"].map((x) => Product.fromJson(x))),
        hotProducts: json["hot_products"] == null
            ? null
            : List<dynamic>.from(json["hot_products"].map((x) => x)),
        latestProducts: json["latest_products"] == null
            ? null
            : List<LatestProduct>.from(
                json["latest_products"].map((x) => LatestProduct.fromJson(x))),
        trendingProducts: json["trending_products"] == null
            ? null
            : List<dynamic>.from(json["trending_products"].map((x) => x)),
        saleProducts: json["sale_products"] == null
            ? null
            : List<dynamic>.from(json["sale_products"].map((x) => x)),
        bestsaleProducts: json["bestsale_products"] == null
            ? null
            : List<dynamic>.from(json["bestsale_products"].map((x) => x)),
        flashdealProducts: json["flashdeal_products"] == null
            ? null
            : List<dynamic>.from(json["flashdeal_products"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sliders": sliders == null
            ? null
            : List<dynamic>.from(sliders.map((x) => x.toJson())),
        "ads":
            ads == null ? null : List<dynamic>.from(ads.map((x) => x.toJson())),
        "premium_products": premiumProducts == null
            ? null
            : List<dynamic>.from(premiumProducts.map((x) => x.toJson())),
        "bigsave_products": bigsaveProducts == null
            ? null
            : List<dynamic>.from(bigsaveProducts.map((x) => x.toJson())),
        "hot_products": hotProducts == null
            ? null
            : List<dynamic>.from(hotProducts.map((x) => x)),
        "latest_products": latestProducts == null
            ? null
            : List<dynamic>.from(latestProducts.map((x) => x.toJson())),
        "trending_products": trendingProducts == null
            ? null
            : List<dynamic>.from(trendingProducts.map((x) => x)),
        "sale_products": saleProducts == null
            ? null
            : List<dynamic>.from(saleProducts.map((x) => x)),
        "bestsale_products": bestsaleProducts == null
            ? null
            : List<dynamic>.from(bestsaleProducts.map((x) => x)),
        "flashdeal_products": flashdealProducts == null
            ? null
            : List<dynamic>.from(flashdealProducts.map((x) => x)),
      };
}

class Ad {
  Ad({
    this.id,
    this.photo,
    this.link,
    this.type,
  });

  int id;
  String photo;
  String link;
  String type;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["id"] == null ? null : json["id"],
        photo: json["photo"] == null ? null : json["photo"],
        link: json["link"] == null ? null : json["link"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "photo": photo == null ? null : photo,
        "link": link == null ? null : link,
        "type": type == null ? null : type,
      };
}

class Product {
  Product({
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
  // String color;
  int price;
  int previousPrice;
  String details;
  dynamic stock;
  String policy;
  int status;
  int views;
  dynamic tags;
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        tags: json["tags"],
        features: json["features"] == null ? null : json["features"],
        colors: json["colors"] == null ? null : json["colors"],
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
        "tags": tags,
        "features": features == null ? null : features,
        "colors": colors == null ? null : colors,
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

enum Policy { BR, NO_RETURN }

final policyValues =
    EnumValues({"<br>": Policy.BR, "No Return": Policy.NO_RETURN});

enum ProductType { NORMAL }

final productTypeValues = EnumValues({"normal": ProductType.NORMAL});

enum Type { PHYSICAL }

final typeValues = EnumValues({"Physical": Type.PHYSICAL});

class LatestProduct {
  LatestProduct({
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
  dynamic childcategoryId;
  dynamic attributes;
  String name;
  String slug;
  String photo;
  String thumbnail;
  dynamic file;
  dynamic size;
  dynamic sizeQty;
  dynamic sizePrice;
  dynamic color;
  int price;
  int previousPrice;
  String details;
  dynamic stock;
  String policy;
  int status;
  int views;
  dynamic tags;
  String features;
  String colors;
  int productCondition;
  String ship;
  int isMeta;
  String metaTag;
  dynamic metaDescription;
  String youtube;
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
  dynamic wholeSellQty;
  dynamic wholeSellDiscount;
  int isCatalog;
  int catalogId;

  factory LatestProduct.fromJson(Map<String, dynamic> json) => LatestProduct(
        id: json["id"] == null ? null : json["id"],
        sku: json["sku"] == null ? null : json["sku"],
        productType: json["product_type"] == null ? null : json["product_type"],
        affiliateLink: json["affiliate_link"],
        userId: json["user_id"] == null ? null : json["user_id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        subcategoryId:
            json["subcategory_id"] == null ? null : json["subcategory_id"],
        childcategoryId: json["childcategory_id"],
        attributes: json["attributes"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        photo: json["photo"] == null ? null : json["photo"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        file: json["file"],
        size: json["size"],
        sizeQty: json["size_qty"],
        sizePrice: json["size_price"],
        color: json["color"],
        price: json["price"] == null ? null : json["price"],
        previousPrice:
            json["previous_price"] == null ? null : json["previous_price"],
        details: json["details"] == null ? null : json["details"],
        stock: json["stock"],
        policy: json["policy"] == null ? null : json["policy"],
        status: json["status"] == null ? null : json["status"],
        views: json["views"] == null ? null : json["views"],
        tags: json["tags"],
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
        wholeSellQty: json["whole_sell_qty"],
        wholeSellDiscount: json["whole_sell_discount"],
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
        "childcategory_id": childcategoryId,
        "attributes": attributes,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "photo": photo == null ? null : photo,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "file": file,
        "size": size,
        "size_qty": sizeQty,
        "size_price": sizePrice,
        "color": color,
        "price": price == null ? null : price,
        "previous_price": previousPrice == null ? null : previousPrice,
        "details": details == null ? null : details,
        "stock": stock,
        "policy": policy == null ? null : policy,
        "status": status == null ? null : status,
        "views": views == null ? null : views,
        "tags": tags,
        "features": features == null ? null : features,
        "colors": colors == null ? null : colors,
        "product_condition": productCondition == null ? null : productCondition,
        "ship": ship == null ? null : ship,
        "is_meta": isMeta == null ? null : isMeta,
        "meta_tag": metaTag == null ? null : metaTag,
        "meta_description": metaDescription,
        "youtube": youtube == null ? null : youtube,
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
        "whole_sell_qty": wholeSellQty,
        "whole_sell_discount": wholeSellDiscount,
        "is_catalog": isCatalog == null ? null : isCatalog,
        "catalog_id": catalogId == null ? null : catalogId,
      };
}

class Slider {
  Slider({
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

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"] == null ? null : json["id"],
        subtitleText:
            json["subtitle_text"] == null ? null : json["subtitle_text"],
        subtitleSize:
            json["subtitle_size"] == null ? null : json["subtitle_size"],
        subtitleColor:
            json["subtitle_color"] == null ? null : json["subtitle_color"],
        subtitleAnime:
            json["subtitle_anime"] == null ? null : json["subtitle_anime"],
        titleText: json["title_text"] == null ? null : json["title_text"],
        titleSize: json["title_size"] == null ? null : json["title_size"],
        titleColor: json["title_color"] == null ? null : json["title_color"],
        titleAnime: json["title_anime"] == null ? null : json["title_anime"],
        detailsText: json["details_text"] == null ? null : json["details_text"],
        detailsSize: json["details_size"] == null ? null : json["details_size"],
        detailsColor:
            json["details_color"] == null ? null : json["details_color"],
        detailsAnime:
            json["details_anime"] == null ? null : json["details_anime"],
        photo: json["photo"] == null ? null : json["photo"],
        position: json["position"] == null ? null : json["position"],
        link: json["link"] == null ? null : json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "subtitle_text": subtitleText == null ? null : subtitleText,
        "subtitle_size": subtitleSize == null ? null : subtitleSize,
        "subtitle_color": subtitleColor == null ? null : subtitleColor,
        "subtitle_anime": subtitleAnime == null ? null : subtitleAnime,
        "title_text": titleText == null ? null : titleText,
        "title_size": titleSize == null ? null : titleSize,
        "title_color": titleColor == null ? null : titleColor,
        "title_anime": titleAnime == null ? null : titleAnime,
        "details_text": detailsText == null ? null : detailsText,
        "details_size": detailsSize == null ? null : detailsSize,
        "details_color": detailsColor == null ? null : detailsColor,
        "details_anime": detailsAnime == null ? null : detailsAnime,
        "photo": photo == null ? null : photo,
        "position": position == null ? null : position,
        "link": link == null ? null : link,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
