import 'package:flutter/material.dart';
import 'dart:convert';

class CartProduct {
  int id;
  String name;
  double price;
  String image;
  int qty;

  CartProduct();

  CartProduct.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        price = json["price"],
        image = json["image"],
        qty = json["qty"];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'price': price, 'image': image, 'qty': qty};
}
