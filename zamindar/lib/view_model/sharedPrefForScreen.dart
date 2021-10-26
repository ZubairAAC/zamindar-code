import 'package:shared_preferences/shared_preferences.dart';
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
  user.userlogin = false;
  print("sp removed user is logout");
}
