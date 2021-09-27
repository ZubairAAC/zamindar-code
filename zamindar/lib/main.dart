import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamindar/model/translations.dart';
import 'package:zamindar/provider/theme.dart';
import 'package:zamindar/view/myhome.dart';

void main() {
  runApp(MyApp());
}

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
      home: HomeScreen(),
      title: 'zamindar',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}
// currentTheme.currentTheme