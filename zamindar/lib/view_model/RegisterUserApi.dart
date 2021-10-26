import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:zamindar/model/user.dart';

Future registerUser() async {
  var dio = new Dio();
  final String url = 'https://zamindarapi.herokuapp.com/user';
  final int number1 = Random().nextInt(99);
  final int number2 = Random().nextInt(99);
  String appname = 'Zamindar';
  final String finalId = number1.toString() + appname + number2.toString();

  FormData formData = new FormData.fromMap({
    "id": finalId,
    "name": user.name,
    "phone": "user.phone",
    "image": user.image,
    "gender": user.gender,
    "Join-Date": DateTime.now()
  });

  try {
    print(formData.fields);
    var response = await dio.post(url,
        data: formData,
        options:
            Options(followRedirects: false, validateStatus: (status) => true));
    print("this is respone data =======>${response.data}");
    return response.data;
  } on HttpStatus catch (e) {
    print("this is error ========>$e");
  }
}
