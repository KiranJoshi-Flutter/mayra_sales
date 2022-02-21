// To parse this JSON data, do
//
//     final checkout = checkoutFromJson(jsonString);

import 'dart:convert';

Checkout checkoutFromJson(String str) => Checkout.fromJson(json.decode(str));

String checkoutToJson(Checkout data) => json.encode(data.toJson());

class Checkout {
  Checkout({
    this.status,
    this.paymentMethods,
    this.shippingPrice,
    this.totalWithoutShipping,
    this.cashOnDelivery,
  });

  String status;
  List<PaymentMethod> paymentMethods;
  dynamic shippingPrice;
  dynamic totalWithoutShipping;
  int cashOnDelivery;

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
        status: json["status"],
        paymentMethods: List<PaymentMethod>.from(
            json["payment_methods"].map((x) => PaymentMethod.fromJson(x))),
        shippingPrice: json["shipping_price"],
        totalWithoutShipping: json["total_without_shipping"],
        cashOnDelivery: json["cash_on_delivery"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "payment_methods":
            List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
        "shipping_price": shippingPrice,
        "total_without_shipping": totalWithoutShipping,
        "cash_on_delivery": cashOnDelivery,
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
        id: json["id"],
        userId: json["user_id"],
        subtitle: json["subtitle"],
        title: json["title"],
        details: json["details"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "subtitle": subtitle,
        "title": title,
        "details": details,
        "status": status,
      };
}
