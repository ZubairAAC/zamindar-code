import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:zamindar/model/user.dart';
import 'package:intl/intl.dart';
import 'package:zamindar/view_model/sqfliteDb.dart';

Future registerUser() async {
  final String url = 'https://zamindarapi.herokuapp.com/user/';
  final int number1 = Random().nextInt(99);
  final int number2 = Random().nextInt(99);
  String appname = 'Zamindar';
  final String finalId = number1.toString() + appname + number2.toString();
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  String formattedDate = formatter.format(now);
  var myJoiningDate = '$formattedDate';
  var latlong = "${UserLocation.lat} : ${UserLocation.long}";
  var joinLoc = "${UserLocation.street}";

  var data = {
    "id": finalId,
    "name": user.name,
    "phone": user.phone,
    "image": user.image,
    "gender": user.gender,
    "JoinDate": myJoiningDate,
    "latLong": latlong,
    "JoinLoc": joinLoc,
  };
  var hitrespons;
  var realID;
  try {
    var res = await http
        .post(Uri.parse('https://zamindarapi.herokuapp.com/user/'), body: data);

    if (res.statusCode == 200) {
      var body = res.body.toString();
      var newbody = jsonDecode(body);
      hitrespons = newbody['respone'];
      realID = finalId;
    }
    if (hitrespons == 'Success') {
      createNewUserInDB(user.name, user.phone, user.image, user.gender, realID);
      return true;
    } else {
      return false;
    }
  } on HttpStatus catch (e) {
    print(e);
  }
}

Future<void> createNewUserInDB(String name, String? phone, String image,
    String gender, String myid) async {
  await UserDB.createUser(name, phone, image, gender, myid);
}

Future<void> getUserInfoWhoISLogin() async {
  List info = await UserDB.getItems();
  print(info);
}
