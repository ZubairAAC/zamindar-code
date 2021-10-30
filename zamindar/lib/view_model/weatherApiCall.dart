import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zamindar/model/weather.dart';

Future<List<Weather>> weatherApi(double lat, double long) async {
  List<Weather> sevendayWeather = [];
  String url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,hourly&appid=eadd56d8694731a421551321bd89e5f5';
  Uri myurl = Uri.parse(url);
  var res = await http.get(myurl);
  if (res.statusCode == 200) {
    String jsonsDataString = res.body.toString();
    var body = jsonDecode(jsonsDataString);
    // print(body);
    WeatherForApi.sunrise = body['current']['sunrise'];
    WeatherForApi.sunset = body['current']['sunset'];
    WeatherForApi.temp = body['current']['temp'];
    WeatherForApi.humidity = body['current']['humidity'];
    WeatherForApi.visibility = body['current']['visibility'];
    var current = body["current"];
    WeatherForApi.name = current["weather"][0]["description"].toString();
    WeatherForApi.img =
        findIcon(current["weather"][0]["main"].toString(), true);

    for (var i = 1; i < 8; i++) {
      var temp = body["daily"][i];
      var hourly = Weather(
          max: temp["temp"]["max"]?.round() ?? 0,
          min: temp["temp"]["min"]?.round() ?? 0,
          image: findIcon(temp["weather"][0]["main"].toString(), true),
          name: temp["weather"][0]["description"].toString(),
          day: '',
          chanceRain: 0,
          current: 0,
          humidity: 0,
          time: '',
          wind: 0);
      // WeatherForApi.sevenDay.add(hourly);
      sevendayWeather.add(hourly);
      // print(WeatherForApi.sevenDay);
    }
  }
  return sevendayWeather;
}
