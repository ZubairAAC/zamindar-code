import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamindar/model/irrigationTime.dart';
import 'package:zamindar/model/user.dart';

setVisitedFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool("Already Visited", true);
  print("visited =====> true");
}

getVisitedFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool alreadyVisited = sp.getBool("Already Visited") ?? false;
  print("visited =====> $alreadyVisited");
  return alreadyVisited;
}

setIsLoginFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool("isLogin", true);
  user.userlogin = true;
  print("user login is ======>${user.userlogin}");
}

getIsLoginFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool loginchecker = sp.getBool("isLogin") ?? false;
  user.userlogin = loginchecker;
  print("user is login at Home Screen =====> ${user.userlogin}");
  return loginchecker;
}

removeIsLoginFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool("isLogin", false);
  sp.setBool('isFarmSelected', false);
  user.userlogin = false;
  print("sp removed user is logout");
}

setIsFarmSelectedFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool("isFarmSelected", true);
  irrigationTime.farmSelected = true;
}

getIsFarmSelectedFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool loginchecker = sp.getBool("isFarmSelected") ?? false;
  irrigationTime.farmSelected = loginchecker;
  print("farm selection is set to ===> $loginchecker");
  return loginchecker;
}

setIrrigationTimeFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString("startDay", irrigationTime.startDay as String);
  sp.setString("endDay", irrigationTime.endDay as String);
  sp.setString("startTime", irrigationTime.startTime as String);
  sp.setString("endTime", irrigationTime.endTime as String);
}

getIrrigationTimeFlag() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  irrigationTime.startDay = sp.getString("startDay");
  irrigationTime.endDay = sp.getString("endDay");
  irrigationTime.startTime = sp.getString("startTime");
  irrigationTime.endTime = sp.getString("endTime");
}
