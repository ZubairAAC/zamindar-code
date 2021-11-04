import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zamindar/model/translations.dart';
import 'package:zamindar/provider/theme.dart';
import 'package:zamindar/view/parent/OnBoardLan.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool vFlag = false;
  //

  vFlag = await getVisitedFlag();
  print("vFlag is ===> $vFlag");
  runApp(MyApp(
    flag: vFlag,
  ));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  bool flag;

  MyApp({Key? key, required this.flag}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState(flag);
}

class _MyAppState extends State<MyApp> {
  bool flag;

  _MyAppState(this.flag);

  @override
  void initState() {
    super.initState();
    print("flag is ====> $flag");

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
      home: flag ? HomeScreen() : StartLanguageScreen(),
      title: 'zamindar',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}
// currentTheme.currentTheme
