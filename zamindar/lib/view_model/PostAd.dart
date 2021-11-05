import 'dart:convert';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:zamindar/model/MarketPost.dart';

Future postAd(
    String title,
    String price,
    String? category,
    String description,
    String? city,
    String imgLength,
    List images,
    String person_name,
    String person_photo,
    String person_phone) async {
  var hitrespons;
  var data = {
    "title": title,
    "price": price,
    "category": category,
    "description": description,
    "city": city,
    "imgLength": imgLength,
    "images": "images",
    "person": person_name,
    "photo": person_photo,
    "phone": person_phone,
  };
  try {
    var res = await http
        .post(Uri.parse('https://zamindarapi.herokuapp.com/ad/'), body: data);

    if (res.statusCode == 200) {
      var body = res.body.toString();
      var newbody = jsonDecode(body);
      hitrespons = newbody['respone'];
    }
    if (hitrespons == 'Success') {
      return true;
    } else {
      return false;
    }
  } on HttpStatus catch (e) {
    print(e);
  }
}

Future<List<Ads>> getADSFromApi() async {
  List<Ads> infoApi = [];
  String url = "https://zamindarapi.herokuapp.com/ad/";
  Uri myurl = Uri.parse(url);
  var res = await http.get(myurl);
  var body = jsonDecode(res.body);
  for (var i = 0; i < body.length; i++) {
    infoApi.add(Ads.fromJson(body[i]));
  }
  return infoApi;
}
