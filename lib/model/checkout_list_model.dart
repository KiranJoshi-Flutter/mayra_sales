// To parse this JSON data, do
//
//     final checkoutListModel = checkoutListModelFromJson(jsonString);

import 'dart:convert';

CheckoutListModel checkoutListModelFromJson(String str) =>
    CheckoutListModel.fromJson(json.decode(str));

String checkoutListModelToJson(CheckoutListModel data) =>
    json.encode(data.toJson());

class CheckoutListModel {
  CheckoutListModel({
    this.status,
    this.paymentMethods,
    this.shippingPrice,
    this.totalWithoutShipping,
    this.cashOnDelivery,
  });

  String status;
  List<PaymentMethod> paymentMethods;
  int shippingPrice;
  int totalWithoutShipping;
  int cashOnDelivery;

  factory CheckoutListModel.fromJson(Map<String, dynamic> json) =>
      CheckoutListModel(
        status: json["status"] == null ? null : json["status"],
        paymentMethods: json["payment_methods"] == null
            ? null
            : List<PaymentMethod>.from(
                json["payment_methods"].map((x) => PaymentMethod.fromJson(x))),
        shippingPrice:
            json["shipping_price"] == null ? null : json["shipping_price"],
        totalWithoutShipping: json["total_without_shipping"] == null
            ? null
            : json["total_without_shipping"],
        cashOnDelivery:
            json["cash_on_delivery"] == null ? null : json["cash_on_delivery"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "payment_methods": paymentMethods == null
            ? null
            : List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
        "shipping_price": shippingPrice == null ? null : shippingPrice,
        "total_without_shipping":
            totalWithoutShipping == null ? null : totalWithoutShipping,
        "cash_on_delivery": cashOnDelivery == null ? null : cashOnDelivery,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.userId,
    this.subtitle,
    this.title,
    this.details,
    this.status,
  });

  int id;
  int userId;
  String subtitle;
  String title;
  String details;
  int status;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        subtitle: json["subtitle"] == null ? null : json["subtitle"],
        title: json["title"] == null ? null : json["title"],
        details: json["details"] == null ? null : json["details"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "subtitle": subtitle == null ? null : subtitle,
        "title": title == null ? null : title,
        "details": details == null ? null : details,
        "status": status == null ? null : status,
      };
}
