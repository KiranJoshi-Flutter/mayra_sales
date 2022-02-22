// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

VendorOrderModel vendorOrderModelFromJson(String str) =>
    VendorOrderModel.fromJson(json.decode(str));

String welcomeToJson(VendorOrderModel data) => json.encode(data.toJson());

class VendorOrderModel {
  VendorOrderModel({
    this.status,
    this.details,
  });

  String status;
  List<Detail> details;

  factory VendorOrderModel.fromJson(Map<String, dynamic> json) =>
      VendorOrderModel(
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
    this.orderId,
    this.qty,
    this.price,
    this.orderNumber,
    this.status,
    this.conversationId,
    this.payAmount,
    this.method,
  });

  int id;
  int userId;
  int orderId;
  int qty;
  int price;
  String orderNumber;
  String status;
  int conversationId;
  int payAmount;
  dynamic method;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        qty: json["qty"],
        price: json["price"],
        orderNumber: json["order_number"],
        status: json["status"],
        conversationId: json["conversation_id"],
        payAmount: json["pay_amount"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "qty": qty,
        "price": price,
        "order_number": orderNumber,
        "status": status,
        "conversation_id": conversationId,
        "pay_amount": payAmount,
        "method": method,
      };
}
