import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamindar/model/translations.dart';
import 'package:zamindar/provider/theme.dart';
import 'package:zamindar/view/parent/OnBoardLan.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: myTranslations(),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      home: StartLanguageScreen(),
      title: 'zamindar',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}
// currentTheme.currentTheme