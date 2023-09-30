import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';

//List<ListResponse> postFromJson(String str) => List<ListResponse>.from(json.decode(str).map((x) => ListResponse.fromJson(x)));

//String postToJson(List<ListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResponsse {
  final String Product_Id;
  final String Product_Image;
  final String Product_Name;
  final dynamic Market_Price;
  final dynamic Total_Market_Price;
  final dynamic Selling_Price;
  final dynamic  Selling_Qty;
  final dynamic Market_Qty;
final String Kg_Ltr;
final dynamic Total_Selling_Price;
  ProductResponsse({
    required this.Product_Id,
    required this.Product_Image,
    required this.Product_Name,
    required this.Market_Price,
    required this.Total_Market_Price,
    required this.Selling_Price,
    required this.Selling_Qty,
    required this.Market_Qty,
    required this.Kg_Ltr,
    required this.Total_Selling_Price


  });
  factory ProductResponsse.fromJson(Map<String, dynamic> json) => ProductResponsse(
    Product_Id: json["Product Id"],
    Product_Image: json["Product Image"],
    Product_Name: json["Product Name"],
    Market_Price: json["Market Price"],
    Total_Market_Price: json["Total Market Price"],
    Selling_Price: json["Selling Price"],
    Selling_Qty: json["Selling Qty"],
    Market_Qty: json["Market Qty"],
      Kg_Ltr:json["Kg_Ltr"],
    Total_Selling_Price:json["Total Selling Price"]

  );
  Map<String, dynamic> toJson() => {
    "Product Name": Product_Name,
    "Product Id": Product_Id,
    "Product Image": Product_Image,
    "Market Price":Market_Price,
    "Total Market Price":Total_Market_Price,
    "Selling Price":Selling_Price,
    "Selling Qty":Selling_Qty,
    "Market Qty":Market_Qty,
    "Kg_Ltr":Kg_Ltr,
    "Total Selling Price":Total_Selling_Price

  };
}

