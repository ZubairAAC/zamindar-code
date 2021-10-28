import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zamindar/model/weather.dart';

Future<List<WeatherForApi>> weatherApi(double lat, double long) async {
  List<WeatherForApi> infoFromWeatherApi = [];
  String url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,hourly&appid=eadd56d8694731a421551321bd89e5f5';
  Uri myurl = Uri.parse(url);
  var res = await http.get(myurl);
  if (res.statusCode == 200) {
    var body = jsonDecode(res.body);
    print(body);
  }

  return infoFromWeatherApi;
}
