import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:zamindar/model/user.dart';

Future registerUser() async {
  var dio = new Dio();
  final String url = 'http://10.0.2.2:8000/user/';
  final int number1 = Random().nextInt(99);
  final int number2 = Random().nextInt(99);
  String appname = 'Zamindar';
  final String finalId = number1.toString() + appname + number2.toString();
  dynamic data = {
    "id": finalId,
    "name": user.name,
    "phone": user.phone,
    "image": user.image,
    "gender": user.gender
  };

  try {
    var response = await dio.post(url, data: data);
    print(response.data);
    return response.data;
  } on HttpStatus catch (e) {
    print(e);
  }
}
