// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) =>
    UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) =>
    json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    this.id,
    this.name,
    this.photo,
    this.zip,
    this.city,
    this.country,
    this.address,
    this.phone,
    this.fax,
    this.email,
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
  });

  int id;
  String name;
  dynamic photo;
  dynamic zip;
  dynamic city;
  dynamic country;
  String address;
  String phone;
  dynamic fax;
  String email;
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

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        zip: json["zip"],
        city: json["city"],
        country: json["country"],
        address: json["address"],
        phone: json["phone"],
        fax: json["fax"],
        email: json["email"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "zip": zip,
        "city": city,
        "country": country,
        "address": address,
        "phone": phone,
        "fax": fax,
        "email": email,
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
      };
}
