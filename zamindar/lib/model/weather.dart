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
  static String cinditions = '';
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
  final String cinditions;

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
    required this.cinditions,
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

findWeatherConditions(String name, bool type) {
  if (type) {
    switch (name) {
      case "200":
        return 'thunderstorm with light rain';
        break;
      case "201":
        return "thunderstorm with rain";
        break;
      case "202":
        return "thunderstorm with heavy rain";
        break;
      case "210":
        return "light thunderstorm";
        break;
      case "211":
        return "thunderstorm";
        break;
      case "212":
        return "heavy thunderstorm";
        break;
      case "221":
        return "ragged thunderstorm";
        break;
      case "230":
        return "thunderstorm with light drizzle";
        break;
      case "231":
        return "thunderstorm with drizzle	";
        break;
      case "232":
        return "thunderstorm with heavy drizzle";
        break;
      case "300":
        return "light intensity drizzle";
        break;
      case "301":
        return "drizzle";
        break;
      case "302":
        return "heavy intensity drizzle";
        break;
      case "310":
        return "light intensity drizzle rain";
        break;

      case "311":
        return "drizzle rain";
        break;
      case "312":
        return "heavy intensity drizzle rain";
        break;
      case "313":
        return "shower rain and drizzle";
        break;
      case "314":
        return "heavy shower rain and drizzle";
        break;
      case "321":
        return "shower drizzle";
        break;
      case "500":
        return "light rain";
        break;
      case "501":
        return "moderate rain";
        break;
      case "502":
        return "heavy intensity rain";
        break;
      case "503":
        return "very heavy rain";
        break;
      case "504":
        return "extreme rain";
        break;
      case "511":
        return "freezing rain";
        break;
      case "520":
        return "light intensity shower rain";
        break;
      case "521":
        return "shower rain";
        break;
      case "522":
        return "heavy intensity shower rain";
        break;
      case "531":
        return "ragged shower rain";
        break;
      case "600":
        return "light snow";
        break;
      case "601":
        return "Snow";
        break;
      case "602":
        return "Heavy snow";
        break;
      case "611":
        return "Sleet";
        break;
      case "612":
        return "Light shower sleet";
        break;
      case "613":
        return "Shower sleet";
        break;
      case "615":
        return "Light rain and snow	";
        break;
      case "616":
        return "Rain and snow";
        break;
      case "620":
        return "Light shower snow";
        break;
      case "621":
        return "Shower snow";
        break;
      case "622":
        return "Heavy shower snow";
        break;
      case "701":
        return "mist";
        break;
      case "711":
        return "Smoke";
        break;
      case "721":
        return "Haze";
        break;
      case "731":
        return "sand/ dust whirls";
        break;
      case "741":
        return "fog";
        break;
      case "751":
        return "sand";
        break;
      case "761":
        return "dust";
        break;
      case "762":
        return "volcanic ash";
        break;
      case "771":
        return "squalls";
        break;
      case "781":
        return "tornado";
        break;
      case "800":
        return "clear sky";
        break;
      case "801":
        return "few clouds";
        break;
      case "802":
        return "scattered clouds";
        break;
      case "803":
        return "broken clouds";
        break;
      case "804":
        return "overcast clouds";
        break;

      default:
        return "Clear Sky";
    }
  }
}
