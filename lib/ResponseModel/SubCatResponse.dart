import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';

//List<ListResponse> postFromJson(String str) => List<ListResponse>.from(json.decode(str).map((x) => ListResponse.fromJson(x)));

//String postToJson(List<ListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCatResponse {
  final String sub_category_id;
  final String sub_category_name;
  final String sub_category_image;
  final String market_price;
  final String category_id;

  SubCatResponse({
    required this.sub_category_id,
    required this.sub_category_name,
    required this.sub_category_image,
    required this.market_price,
    required this.category_id
  });
  factory SubCatResponse.fromJson(Map<String, dynamic> json) => SubCatResponse(
    sub_category_id: json["sub_category_id"],
    sub_category_name: json["sub_category_name"],
    sub_category_image: json["sub_category_image"],
    market_price: json["market_price"],
      category_id:json["category_id"]
  );
  Map<String, dynamic> toJson() => {
    "sub_category_id": sub_category_id,
    "sub_category_name": sub_category_name,
    "sub_category_image": sub_category_image,
    "market_price":market_price,
    "category_id":category_id
  };
}

