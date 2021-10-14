import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future checkInternet() async {
  try {
    ConnectivityResult result = await ConnectivityResult.none;
    Connectivity().onConnectivityChanged.listen((result) {
      result = result;
      print(" is here =========> $result");
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected to Mobile Network");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected to wifi");
    } else if (connectivityResult == ConnectivityResult.none) {
      print("no internet");
    }
  } on PlatformException catch (e) {
    print(e.toString());
  }
}

Future connectivityChecker() async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    print('has connection');
  } else {
    print('No internet :( Reason:');
    print(InternetConnectionChecker().connectionStatus);
  }
}
