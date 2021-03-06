// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
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
    var l = Get.locale?.languageCode;

    // ignore: duplicate_ignore
    return ThemeData(
        cardColor: Colors.white,
        brightness: Brightness.light,
        cupertinoOverrideTheme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
          ),
          actionTextStyle: TextStyle(
            fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
          ),
        )),

        // ignore: prefer_const_constructors
        colorScheme: ColorScheme.light(),
        hoverColor: Colors.green,
        primaryColor: Colors.white,
        primaryColorLight: Colors.black,
        primarySwatch: Colors.green,
        accentColor: Colors.green,
        popupMenuTheme: PopupMenuThemeData(
            textStyle: TextStyle(
          fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
        )),
        backgroundColor: Colors.grey[200],
        scaffoldBackgroundColor: Colors.grey[200],
        focusColor: Colors.green,
        shadowColor: Colors.white,
        fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
        textTheme: TextTheme(
            caption: TextStyle(color: Colors.white),
            headline1: TextStyle(color: Colors.green),
            headline2: TextStyle(color: Colors.black),
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black),
            button: TextStyle(
              fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
            )).apply(
          fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
        ),
        // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
        iconTheme: IconThemeData(
          color: Colors.green,
        ));
  }

  static ThemeData get darkTheme {
    var l = Get.locale?.languageCode;

    return ThemeData(
        cardColor: Colors.black,
        primaryColor: Colors.black,
        hoverColor: Colors.black,
        shadowColor: Colors.yellow[700],
        primaryColorLight: Colors.white,
        colorScheme: ColorScheme.dark(),
        primarySwatch: Colors.yellow,
        // ignore: deprecated_member_use
        accentColor: Colors.yellow[700],
        backgroundColor: Colors.grey[900],
        focusColor: Colors.black,
        popupMenuTheme: PopupMenuThemeData(
            textStyle: TextStyle(
          fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
        )),
        scaffoldBackgroundColor: Colors.grey[900],
        // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
        fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.yellow[700]),
            caption: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
            button: TextStyle(
              fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
            )).apply(
          fontFamily: l == 'ur_PK' ? 'Jameel Noori' : null,
        ),
        iconTheme: IconThemeData(
          color: Colors.yellow[700],
        ));
  }
}
