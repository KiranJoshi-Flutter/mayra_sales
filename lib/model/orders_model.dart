// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  OrdersModel({
    this.status,
    this.details,
  });

  String status;
  List<Detail> details;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
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
    this.userId,
    this.cart,
    this.method,
    this.shipping,
    this.pickupLocation,
    this.totalQty,
    this.payAmount,
    this.txnid,
    this.txnImage,
    this.chargeId,
    this.orderNumber,
    this.paymentStatus,
    this.customerEmail,
    this.customerName,
    this.customerCountry,
    this.customerPhone,
    this.customerAddress,
    this.customerCity,
    this.customerZip,
    this.customerLongitude,
    this.customerLatitude,
    this.shippingName,
    this.shippingCountry,
    this.shippingEmail,
    this.shippingPhone,
    this.shippingAddress,
    this.shippingCity,
    this.shippingZip,
    this.shippingLongitude,
    this.shippingLatitude,
    this.orderNote,
    this.couponCode,
    this.couponDiscount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.affilateUser,
    this.affilateCharge,
    this.currencySign,
    this.currencyValue,
    this.shippingCost,
    this.packingCost,
    this.tax,
    this.dp,
    this.payId,
    this.vendorShippingId,
    this.vendorPackingId,
    this.deliveryRangeStart,
    this.deliveryRangeEnd,
    this.reported,
  });

  int id;
  int userId;
  List<Cart> cart;
  String method;
  String shipping;
  dynamic pickupLocation;
  String totalQty;
  int payAmount;
  dynamic txnid;
  dynamic txnImage;
  dynamic chargeId;
  String orderNumber;
  String paymentStatus;
  String customerEmail;
  String customerName;
  String customerCountry;
  String customerPhone;
  String customerAddress;
  dynamic customerCity;
  String customerZip;
  dynamic customerLongitude;
  dynamic customerLatitude;
  dynamic shippingName;
  dynamic shippingCountry;
  String shippingEmail;
  String shippingPhone;
  String shippingAddress;
  dynamic shippingCity;
  dynamic shippingZip;
  dynamic shippingLongitude;
  dynamic shippingLatitude;
  dynamic orderNote;
  dynamic couponCode;
  dynamic couponDiscount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic affilateUser;
  dynamic affilateCharge;
  String currencySign;
  int currencyValue;
  int shippingCost;
  int packingCost;
  int tax;
  int dp;
  dynamic payId;
  int vendorShippingId;
  int vendorPackingId;
  dynamic deliveryRangeStart;
  dynamic deliveryRangeEnd;
  int reported;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        cart: json["cart"] == null
            ? null
            : List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        method: json["method"] == null ? null : json["method"],
        shipping: json["shipping"] == null ? null : json["shipping"],
        pickupLocation: json["pickup_location"],
        totalQty: json["totalQty"] == null ? null : json["totalQty"],
        payAmount: json["pay_amount"] == null ? null : json["pay_amount"],
        txnid: json["txnid"],
        txnImage: json["txn_image"],
        chargeId: json["charge_id"],
        orderNumber: json["order_number"] == null ? null : json["order_number"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        customerEmail:
            json["customer_email"] == null ? null : json["customer_email"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        customerCountry:
            json["customer_country"] == null ? null : json["customer_country"],
        customerPhone:
            json["customer_phone"] == null ? null : json["customer_phone"],
        customerAddress:
            json["customer_address"] == null ? null : json["customer_address"],
        customerCity: json["customer_city"],
        customerZip: json["customer_zip"] == null ? null : json["customer_zip"],
        customerLongitude: json["customer_longitude"],
        customerLatitude: json["customer_latitude"],
        shippingName: json["shipping_name"],
        shippingCountry: json["shipping_country"],
        shippingEmail:
            json["shipping_email"] == null ? null : json["shipping_email"],
        shippingPhone:
            json["shipping_phone"] == null ? null : json["shipping_phone"],
        shippingAddress:
            json["shipping_address"] == null ? null : json["shipping_address"],
        shippingCity: json["shipping_city"],
        shippingZip: json["shipping_zip"],
        shippingLongitude: json["shipping_longitude"],
        shippingLatitude: json["shipping_latitude"],
        orderNote: json["order_note"],
        couponCode: json["coupon_code"],
        couponDiscount: json["coupon_discount"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        affilateUser: json["affilate_user"],
        affilateCharge: json["affilate_charge"],
        currencySign:
            json["currency_sign"] == null ? null : json["currency_sign"],
        currencyValue:
            json["currency_value"] == null ? null : json["currency_value"],
        shippingCost:
            json["shipping_cost"] == null ? null : json["shipping_cost"],
        packingCost: json["packing_cost"] == null ? null : json["packing_cost"],
        tax: json["tax"] == null ? null : json["tax"],
        dp: json["dp"] == null ? null : json["dp"],
        payId: json["pay_id"],
        vendorShippingId: json["vendor_shipping_id"] == null
            ? null
            : json["vendor_shipping_id"],
        vendorPackingId: json["vendor_packing_id"] == null
            ? null
            : json["vendor_packing_id"],
        deliveryRangeStart: json["delivery_range_start"],
        deliveryRangeEnd: json["delivery_range_end"],
        reported: json["reported"] == null ? null : json["reported"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "cart": cart == null
            ? null
            : List<dynamic>.from(cart.map((x) => x.toJson())),
        "method": method == null ? null : method,
        "shipping": shipping == null ? null : shipping,
        "pickup_location": pickupLocation,
        "totalQty": totalQty == null ? null : totalQty,
        "pay_amount": payAmount == null ? null : payAmount,
        "txnid": txnid,
        "txn_image": txnImage,
        "charge_id": chargeId,
        "order_number": orderNumber == null ? null : orderNumber,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "customer_email": customerEmail == null ? null : customerEmail,
        "customer_name": customerName == null ? null : customerName,
        "customer_country": customerCountry == null ? null : customerCountry,
        "customer_phone": customerPhone == null ? null : customerPhone,
        "customer_address": customerAddress == null ? null : customerAddress,
        "customer_city": customerCity,
        "customer_zip": customerZip == null ? null : customerZip,
        "customer_longitude": customerLongitude,
        "customer_latitude": customerLatitude,
        "shipping_name": shippingName,
        "shipping_country": shippingCountry,
        "shipping_email": shippingEmail == null ? null : shippingEmail,
        "shipping_phone": shippingPhone == null ? null : shippingPhone,
        "shipping_address": shippingAddress == null ? null : shippingAddress,
        "shipping_city": shippingCity,
        "shipping_zip": shippingZip,
        "shipping_longitude": shippingLongitude,
        "shipping_latitude": shippingLatitude,
        "order_note": orderNote,
        "coupon_code": couponCode,
        "coupon_discount": couponDiscount,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "affilate_user": affilateUser,
        "affilate_charge": affilateCharge,
        "currency_sign": currencySign == null ? null : currencySign,
        "currency_value": currencyValue == null ? null : currencyValue,
        "shipping_cost": shippingCost == null ? null : shippingCost,
        "packing_cost": packingCost == null ? null : packingCost,
        "tax": tax == null ? null : tax,
        "dp": dp == null ? null : dp,
        "pay_id": payId,
        "vendor_shipping_id":
            vendorShippingId == null ? null : vendorShippingId,
        "vendor_packing_id": vendorPackingId == null ? null : vendorPackingId,
        "delivery_range_start": deliveryRangeStart,
        "delivery_range_end": deliveryRangeEnd,
        "reported": reported == null ? null : reported,
      };
}

class Cart {
  Cart({
    this.qty,
    this.color,
    this.price,
    this.size,
    this.productDetails,
    this.vendorDetails,
  });

  int qty;
  String color;
  int price;
  String size;
  ProductDetails productDetails;
  VendorDetails vendorDetails;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        qty: json["qty"] == null ? null : json["qty"],
        color: json["color"] == null ? null : json["color"],
        price: json["price"] == null ? null : json["price"],
        size: json["size"] == null ? null : json["size"],
        productDetails: json["product_details"] == null
            ? null
            : ProductDetails.fromJson(json["product_details"]),
        vendorDetails: json["vendor_details"] == null
            ? null
            : VendorDetails.fromJson(json["vendor_details"]),
      );

  Map<String, dynamic> toJson() => {
        "qty": qty == null ? null : qty,
        "color": color == null ? null : color,
        "price": price == null ? null : price,
        "size": size == null ? null : size,
        "product_details":
            productDetails == null ? null : productDetails.toJson(),
        "vendor_details": vendorDetails == null ? null : vendorDetails.toJson(),
      };
}

class ProductDetails {
  ProductDetails({
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

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
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
        stock: json["stock"],
        policy: json["policy"] == null ? null : json["policy"],
        status: json["status"] == null ? null : json["status"],
        views: json["views"] == null ? null : json["views"],
        tags: json["tags"] == null ? null : json["tags"],
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
        "color": color == null ? null : color,
        "price": price == null ? null : price,
        "previous_price": previousPrice == null ? null : previousPrice,
        "details": details == null ? null : details,
        "stock": stock,
        "policy": policy == null ? null : policy,
        "status": status == null ? null : status,
        "views": views == null ? null : views,
        "tags": tags == null ? null : tags,
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

class VendorDetails {
  VendorDetails({
    this.id,
    this.name,
    this.photo,
    this.zip,
    this.city,
    this.userLocation,
    this.country,
    this.address,
    this.phone,
    this.fax,
    this.email,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
    this.isProvider,
    this.status,
    this.verificationLink,
    this.emailVerified,
    this.affilateCode,
    this.affilateIncome,
    this.shopName,
    this.ownerName,
    this.shopNumber,
    this.shopAddress,
    this.regNumber,
    this.shopMessage,
    this.shopDetails,
    this.shopImage,
    this.shopLocation,
    this.fUrl,
    this.gUrl,
    this.tUrl,
    this.lUrl,
    this.isVendor,
    this.fCheck,
    this.gCheck,
    this.tCheck,
    this.lCheck,
    this.mailSent,
    this.shippingCost,
    this.currentBalance,
    this.date,
    this.ban,
    this.suspendTill,
    this.paymentRequest,
    this.method,
    this.subsId,
    this.txnId4,
    this.txnImage,
    this.subscriptionType,
    this.reportedTimes,
    this.cashOnly,
    this.deviceToken,
  });

  int id;
  String name;
  dynamic photo;
  dynamic zip;
  String city;
  int userLocation;
  String country;
  String address;
  String phone;
  dynamic fax;
  String email;
  dynamic longitude;
  dynamic latitude;
  DateTime createdAt;
  DateTime updatedAt;
  int isProvider;
  int status;
  String verificationLink;
  String emailVerified;
  String affilateCode;
  int affilateIncome;
  String shopName;
  String ownerName;
  String shopNumber;
  String shopAddress;
  String regNumber;
  String shopMessage;
  String shopDetails;
  dynamic shopImage;
  int shopLocation;
  dynamic fUrl;
  dynamic gUrl;
  dynamic tUrl;
  dynamic lUrl;
  int isVendor;
  int fCheck;
  int gCheck;
  int tCheck;
  int lCheck;
  int mailSent;
  int shippingCost;
  int currentBalance;
  DateTime date;
  int ban;
  dynamic suspendTill;
  int paymentRequest;
  dynamic method;
  int subsId;
  dynamic txnId4;
  dynamic txnImage;
  dynamic subscriptionType;
  int reportedTimes;
  int cashOnly;
  dynamic deviceToken;

  factory VendorDetails.fromJson(Map<String, dynamic> json) => VendorDetails(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"],
        zip: json["zip"],
        city: json["city"] == null ? null : json["city"],
        userLocation:
            json["user_location"] == null ? null : json["user_location"],
        country: json["country"] == null ? null : json["country"],
        address: json["address"] == null ? null : json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        fax: json["fax"],
        email: json["email"] == null ? null : json["email"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isProvider: json["is_provider"] == null ? null : json["is_provider"],
        status: json["status"] == null ? null : json["status"],
        verificationLink: json["verification_link"] == null
            ? null
            : json["verification_link"],
        emailVerified:
            json["email_verified"] == null ? null : json["email_verified"],
        affilateCode:
            json["affilate_code"] == null ? null : json["affilate_code"],
        affilateIncome:
            json["affilate_income"] == null ? null : json["affilate_income"],
        shopName: json["shop_name"] == null ? null : json["shop_name"],
        ownerName: json["owner_name"] == null ? null : json["owner_name"],
        shopNumber: json["shop_number"] == null ? null : json["shop_number"],
        shopAddress: json["shop_address"] == null ? null : json["shop_address"],
        regNumber: json["reg_number"] == null ? null : json["reg_number"],
        shopMessage: json["shop_message"] == null ? null : json["shop_message"],
        shopDetails: json["shop_details"] == null ? null : json["shop_details"],
        shopImage: json["shop_image"],
        shopLocation:
            json["shop_location"] == null ? null : json["shop_location"],
        fUrl: json["f_url"],
        gUrl: json["g_url"],
        tUrl: json["t_url"],
        lUrl: json["l_url"],
        isVendor: json["is_vendor"] == null ? null : json["is_vendor"],
        fCheck: json["f_check"] == null ? null : json["f_check"],
        gCheck: json["g_check"] == null ? null : json["g_check"],
        tCheck: json["t_check"] == null ? null : json["t_check"],
        lCheck: json["l_check"] == null ? null : json["l_check"],
        mailSent: json["mail_sent"] == null ? null : json["mail_sent"],
        shippingCost:
            json["shipping_cost"] == null ? null : json["shipping_cost"],
        currentBalance:
            json["current_balance"] == null ? null : json["current_balance"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        ban: json["ban"] == null ? null : json["ban"],
        suspendTill: json["suspend_till"],
        paymentRequest:
            json["payment_request"] == null ? null : json["payment_request"],
        method: json["method"],
        subsId: json["subs_id"] == null ? null : json["subs_id"],
        txnId4: json["txn_id4"],
        txnImage: json["txn_image"],
        subscriptionType: json["subscription_type"],
        reportedTimes:
            json["reported_times"] == null ? null : json["reported_times"],
        cashOnly: json["cash_only"] == null ? null : json["cash_only"],
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo": photo,
        "zip": zip,
        "city": city == null ? null : city,
        "user_location": userLocation == null ? null : userLocation,
        "country": country == null ? null : country,
        "address": address == null ? null : address,
        "phone": phone == null ? null : phone,
        "fax": fax,
        "email": email == null ? null : email,
        "longitude": longitude,
        "latitude": latitude,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "is_provider": isProvider == null ? null : isProvider,
        "status": status == null ? null : status,
        "verification_link": verificationLink == null ? null : verificationLink,
        "email_verified": emailVerified == null ? null : emailVerified,
        "affilate_code": affilateCode == null ? null : affilateCode,
        "affilate_income": affilateIncome == null ? null : affilateIncome,
        "shop_name": shopName == null ? null : shopName,
        "owner_name": ownerName == null ? null : ownerName,
        "shop_number": shopNumber == null ? null : shopNumber,
        "shop_address": shopAddress == null ? null : shopAddress,
        "reg_number": regNumber == null ? null : regNumber,
        "shop_message": shopMessage == null ? null : shopMessage,
        "shop_details": shopDetails == null ? null : shopDetails,
        "shop_image": shopImage,
        "shop_location": shopLocation == null ? null : shopLocation,
        "f_url": fUrl,
        "g_url": gUrl,
        "t_url": tUrl,
        "l_url": lUrl,
        "is_vendor": isVendor == null ? null : isVendor,
        "f_check": fCheck == null ? null : fCheck,
        "g_check": gCheck == null ? null : gCheck,
        "t_check": tCheck == null ? null : tCheck,
        "l_check": lCheck == null ? null : lCheck,
        "mail_sent": mailSent == null ? null : mailSent,
        "shipping_cost": shippingCost == null ? null : shippingCost,
        "current_balance": currentBalance == null ? null : currentBalance,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "ban": ban == null ? null : ban,
        "suspend_till": suspendTill,
        "payment_request": paymentRequest == null ? null : paymentRequest,
        "method": method,
        "subs_id": subsId == null ? null : subsId,
        "txn_id4": txnId4,
        "txn_image": txnImage,
        "subscription_type": subscriptionType,
        "reported_times": reportedTimes == null ? null : reportedTimes,
        "cash_only": cashOnly == null ? null : cashOnly,
        "device_token": deviceToken,
      };
}
