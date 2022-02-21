import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
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
    this.apiToken,
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
  });

  int id;
  String name;
  dynamic photo;
  dynamic zip;
  dynamic city;
  int userLocation;
  dynamic country;
  String address;
  String phone;
  dynamic fax;
  String email;
  String longitude;
  String latitude;
  String apiToken;
  DateTime createdAt;
  DateTime updatedAt;
  int isProvider;
  int status;
  String verificationLink;
  String emailVerified;
  String affilateCode;
  int affilateIncome;
  dynamic shopName;
  dynamic ownerName;
  dynamic shopNumber;
  dynamic shopAddress;
  dynamic regNumber;
  dynamic shopMessage;
  dynamic shopDetails;
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
  dynamic date;
  int ban;
  dynamic suspendTill;
  int paymentRequest;
  dynamic method;
  dynamic subsId;
  dynamic txnId4;
  dynamic txnImage;
  dynamic subscriptionType;
  int reportedTimes;
  int cashOnly;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        zip: json["zip"],
        city: json["city"],
        userLocation: json["user_location"],
        country: json["country"],
        address: json["address"],
        phone: json["phone"],
        fax: json["fax"],
        email: json["email"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        apiToken: json["api_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isProvider: json["is_provider"],
        status: json["status"],
        verificationLink: json["verification_link"],
        emailVerified: json["email_verified"],
        affilateCode: json["affilate_code"],
        affilateIncome: json["affilate_income"],
        shopName: json["shop_name"],
        ownerName: json["owner_name"],
        shopNumber: json["shop_number"],
        shopAddress: json["shop_address"],
        regNumber: json["reg_number"],
        shopMessage: json["shop_message"],
        shopDetails: json["shop_details"],
        shopImage: json["shop_image"],
        shopLocation: json["shop_location"],
        fUrl: json["f_url"],
        gUrl: json["g_url"],
        tUrl: json["t_url"],
        lUrl: json["l_url"],
        isVendor: json["is_vendor"],
        fCheck: json["f_check"],
        gCheck: json["g_check"],
        tCheck: json["t_check"],
        lCheck: json["l_check"],
        mailSent: json["mail_sent"],
        shippingCost: json["shipping_cost"],
        currentBalance: json["current_balance"],
        date: json["date"],
        ban: json["ban"],
        suspendTill: json["suspend_till"],
        paymentRequest: json["payment_request"],
        method: json["method"],
        subsId: json["subs_id"],
        txnId4: json["txn_id4"],
        txnImage: json["txn_image"],
        subscriptionType: json["subscription_type"],
        reportedTimes: json["reported_times"],
        cashOnly: json["cash_only"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "zip": zip,
        "city": city,
        "user_location": userLocation,
        "country": country,
        "address": address,
        "phone": phone,
        "fax": fax,
        "email": email,
        "longitude": longitude,
        "latitude": latitude,
        "api_token": apiToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_provider": isProvider,
        "status": status,
        "verification_link": verificationLink,
        "email_verified": emailVerified,
        "affilate_code": affilateCode,
        "affilate_income": affilateIncome,
        "shop_name": shopName,
        "owner_name": ownerName,
        "shop_number": shopNumber,
        "shop_address": shopAddress,
        "reg_number": regNumber,
        "shop_message": shopMessage,
        "shop_details": shopDetails,
        "shop_image": shopImage,
        "shop_location": shopLocation,
        "f_url": fUrl,
        "g_url": gUrl,
        "t_url": tUrl,
        "l_url": lUrl,
        "is_vendor": isVendor,
        "f_check": fCheck,
        "g_check": gCheck,
        "t_check": tCheck,
        "l_check": lCheck,
        "mail_sent": mailSent,
        "shipping_cost": shippingCost,
        "current_balance": currentBalance,
        "date": date,
        "ban": ban,
        "suspend_till": suspendTill,
        "payment_request": paymentRequest,
        "method": method,
        "subs_id": subsId,
        "txn_id4": txnId4,
        "txn_image": txnImage,
        "subscription_type": subscriptionType,
        "reported_times": reportedTimes,
        "cash_only": cashOnly,
      };
}
