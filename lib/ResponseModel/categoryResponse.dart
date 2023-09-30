import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';

//List<ListResponse> postFromJson(String str) => List<ListResponse>.from(json.decode(str).map((x) => ListResponse.fromJson(x)));

//String postToJson(List<ListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListResponse {
  final String category_id;
 final String category_image;
 final String category_name;
 final String status;

  ListResponse({
    required this.category_id,
    required this.category_image,
    required this.category_name,
    required this.status,
  });
  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
      category_id: json["category_id"],
      category_image: json["category_image"],
      category_name: json["category_name"],
      status: json["status"],
       );
  Map<String, dynamic> toJson() => {
    "category_name": category_name,
    "category_id": category_id,
    "category_image": category_image,
    "status":status,
  };
}

