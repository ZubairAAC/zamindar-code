import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zamindar/model/info.dart';

Future<List<Info>> getInfoFromApi() async {
  List<Info> infoApi = [];
  String url = "https://zamindarapi.herokuapp.com/info";
  Uri myurl = Uri.parse(url);
  var res = await http.get(myurl);
  var body = jsonDecode(res.body);
  for (var i = 0; i < body.length; i++) {
    infoApi.add(Info.fromJson(body[i]));
  }
  return infoApi;
}
