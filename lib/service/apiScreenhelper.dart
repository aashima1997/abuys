import 'dart:convert';
import 'package:abuys/Constants.dart';
import 'package:abuys/ResponseModel/SubCatResponse.dart';
import 'package:abuys/ResponseModel/categoryResponse.dart';
import 'package:abuys/ResponseModel/productResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ApiScreenHelper {
  static Future<List<ProductResponsse>> getProd(double lat,double long,String catid, String subcatId) async {
    var listRes = http.Client();
    String lattoString=lat.toString();
    String longtoString=long.toString();
    var data;
    try {
      var url = Uri.parse("https://abuysweb.coderzbot.com/api/get_product.php?buyer_id=94&latitude=$lattoString&longitude=$longtoString&category_id=$catid&sub_category_id=$subcatId&search_key=");
print("url"+url.toString());
      var response = await listRes.get(url);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print("KnowledgerevNo $data");
      }
    } catch (e) {
      print(e);
    }
    return data.map<ProductResponsse>((e) => ProductResponsse.fromJson(e)).toList();
  }

  static Future<List<ListResponse>> getcatog(BuildContext context) async {
    var listRes = http.Client();
    var data;
    try {
      var url = Uri.parse("https://abuysweb.coderzbot.com/api/category.php");

      var response = await listRes.get(url);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print("KnowledgerevNo $data");
      }
    } catch (e) {
      print(e);
    }

    return data.map<ListResponse>((e) => ListResponse.fromJson(e)).toList();
  }

  static Future<List<ListResponse>> getProdbyCateg(BuildContext context,String catName) async {
    var listRes = http.Client();
    var data;
    try {
      var url = Uri.parse("prodbycateg"+"/$catName");

      var response = await listRes.get(url);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print("KnowledgerevNo1 $data");
      }
    } catch (e) {
      print(e);
    }
    return data.map<ListResponse>((e) => ListResponse.fromJson(e)).toList();
  }
  static Future<List<SubCatResponse>> getProdbysubCateg(BuildContext context,String catId) async {
    var listRes = http.Client();
    int subcatId=int.parse(catId);
    var data;
    try {
      var url = Uri.parse("https://abuysweb.coderzbot.com/api/sub_category.php?category_id="+"$catId");
print(url);
      var response = await listRes.get(url);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print("KnowledgerevNo2 $data");
      }
    } catch (e) {
      print(e);
    }
    return data.map<SubCatResponse>((e) => SubCatResponse.fromJson(e)).toList();
  }
  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 12.0);
  }


}