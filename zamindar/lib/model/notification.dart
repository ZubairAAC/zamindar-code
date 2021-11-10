import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:zamindar/view/parent/myhome.dart';

class notification {
  static List dates = [];
  static int min = 0;
  static int max = 0;
  static String name = '';
}

Future getTommorrowWeather() async {
  var data = {
    "Date": notification.dates,
    "Max-temp": notification.max,
    "Min temp": notification.min,
    "Description": notification.name
  };
  DateTime date = DateTime.now();
  var _dayFormatter = DateFormat('dd-MM-yyyy');
  var myday = _dayFormatter.format(date);
  final time = DateFormat().add_jm().format(DateTime.now());
  // print(data["Date"]);
  var tmw = notification.dates.first;
  var minForTommow = notification.min;
  var maxForTommow = notification.max;

  // }
  if (tmw == myday) {
    print("match");
    if (time == "8:00 AM") {
      HomeScreen().createState().showOnDayWeatherNotification(
          notification.name.tr, minForTommow, maxForTommow, myday);
    }
  } else if (tmw != myday) {
    if (time == "8:00 PM") {
      // var urdu = 'ur_PK';
      // Get.updateLocale(urdu);
      HomeScreen().createState().showBeforeDayWeatherNotification(
          notification.name.tr, minForTommow, maxForTommow, tmw);
      print(
          "کل ${myday} کو موسم ${notification.name.tr} ہوگا۔ کم سے کم درجہ حرارت ${minForTommow} ہو گا اور زیادہ سے زیادہ درجہ حرارت ${maxForTommow} ہوگا۔");
    }
  }
}
