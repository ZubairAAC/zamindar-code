import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:get/instance_manager.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    // print('Theme changed to $_isDarkTheme');
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
        cardColor: Colors.white,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(),
        hoverColor: Colors.green,
        primaryColor: Colors.white,
        primaryColorLight: Colors.black,
        primarySwatch: Colors.green,
        accentColor: Colors.green,
        backgroundColor: Colors.grey[200],
        scaffoldBackgroundColor: Colors.grey[200],
        focusColor: Colors.green,
        shadowColor: Colors.white,
        textTheme: TextTheme(
          caption: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.green),
          headline2: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.green,
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        cardColor: Colors.black,
        primaryColor: Colors.black,
        hoverColor: Colors.black,
        shadowColor: Colors.yellow[700],
        primaryColorLight: Colors.white,
        colorScheme: ColorScheme.dark(),
        primarySwatch: Colors.yellow,
        accentColor: Colors.yellow[700],
        backgroundColor: Colors.grey[900],
        focusColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.yellow[700]),
          caption: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ).apply(),
        iconTheme: IconThemeData(
          color: Colors.yellow[700],
        ));
  }
}
