import 'dart:developer';

import 'package:api_services/modal/usermodal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserModalProvider extends ChangeNotifier {
  Dio dio = Dio();
  final url = "https://api.escuelajs.co/api/v1/users";

  Future<List<Usermodal>> getUserData() async {
    final response = await dio.get(url);
    List<dynamic> responsee = response.data;

    log("gruhbfjn${response.data}");
    return List<Usermodal>.from(responsee.map((e) => Usermodal.fromJson(e)));
  }
}
