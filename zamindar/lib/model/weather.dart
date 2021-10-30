import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherForApi {
  static int sunrise = 0;
  static int sunset = 0;
  static double temp = 0;
  static int humidity = 0;
  static int visibility = 0;
  static String description = '';
  static String name = '';
  static String img = '';
  static List<Weather> sevenDay = [];
}

class Weather {
  final int max;
  final int min;
  final int current;
  final String name;
  final String day;
  final int wind;
  final int humidity;
  final int chanceRain;
  final String image;
  final String time;

  Weather({
    required this.max,
    required this.min,
    required this.name,
    required this.day,
    required this.wind,
    required this.humidity,
    required this.chanceRain,
    required this.image,
    required this.current,
    required this.time,
  });
}

//findIcon
String findIcon(String name, bool type) {
  if (type) {
    switch (name) {
      case "Clouds":
        return "asset/weatherIcon/few clouds.png";
        break;
      case "Rain":
        return "asset/weatherIcon/rain.png";
        break;
      case "Drizzle":
        return "asset/weatherIcon/shower rain.png";
        break;
      case "Thunderstorm":
        return "asset/weatherIcon/thunderstorm.png";
        break;
      case "Snow":
        return "asset/weatherIcon/snow.png";
        break;
      case "Mist":
        return "asset/weatherIcon/mist.png";
        break;
      case "Smoke":
        return "asset/weatherIcon/mist.png";
        break;
      case "Haze":
        return "asset/weatherIcon/mist.png";
        break;
      case "Dust":
        return "asset/weatherIcon/mist.png";
        break;
      case "Fog":
        return "asset/weatherIcon/mist.png";
        break;
      case "Sand":
        return "asset/weatherIcon/mist.png";
        break;
      case "Ash":
        return "asset/weatherIcon/mist.png";
        break;
      case "Squall":
        return "asset/weatherIcon/mist.png";
        break;
      case "Tornado":
        return "asset/weatherIcon/mist.png";
        break;
      default:
        return "asset/weatherIcon/clear sky.png";
    }
  } else {
    switch (name) {
      case "Clouds":
        return "assets/sunny_2d.png";
        break;
      case "Rain":
        return "assets/rainy_2d.png";
        break;
      case "Drizzle":
        return "assets/rainy_2d.png";
        break;
      case "Thunderstorm":
        return "assets/thunder_2d.png";
        break;
      case "Snow":
        return "assets/snow_2d.png";
        break;
      default:
        return "assets/sunny_2d.png";
    }
  }
}
