import 'package:api_services/modal/product_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Productdataa extends ChangeNotifier {
  final String url = "https://api.escuelajs.co/api/v1/products";
  final Dio dio = Dio();
  getData() async {
    Response response = await dio.get(url);
    List<dynamic> responce = response.data;

    return List<Productdata>.from(responce.map((e) => Productdata.fromJson(e)));
  }
}
