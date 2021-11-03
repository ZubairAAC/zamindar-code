import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fn;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zamindar/model/irrigationTime.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/crops.dart';
import 'package:zamindar/view/home.dart';
import 'package:zamindar/view/market.dart';
import 'package:zamindar/view/message.dart';
import 'package:zamindar/view/profile.dart';
import 'package:zamindar/view/onboardingLogin/LoginChecker.dart';
import 'package:zamindar/view/HomeChilds/drawer.dart';
import 'package:zamindar/view_model/IrrigationAlerts.dart';
import 'package:zamindar/view_model/getInfo.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';
import 'package:zamindar/view_model/sqfliteDb.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  fn.FlutterLocalNotificationsPlugin notification =
      fn.FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
    getIsLoginFlag();
    getNotification();
    getFlag();
    getInfoFromApi();
  }

  getFlag() async {
    getIrrigationTimeFlag();
  }

  getNotification() async {
    const fn.AndroidInitializationSettings initializationSettingsAndroid =
        fn.AndroidInitializationSettings('app_icon');
    const initializationSettings =
        fn.InitializationSettings(android: initializationSettingsAndroid);
    notification.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  int _selectedIndex = 0;
  bool _isLogin = false;
  List<Widget> tabs = [mainHome(), Market(), crops(), Message(), profile()];
  PageController _pageController = PageController();
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      // changeTabOnUserState();
      if (_selectedIndex == 2 || _selectedIndex == 3 || _selectedIndex == 4) {
        gotTapped();
        return user.userlogin ? Market() : Login().loginCheckers(context);
      }
      // print(user.userlogin);
      // tabs[1] = user.userlogin ? Market() : Login().loginCheckers(context);
      print(index);
      gotTapped();
    });
  }

  void _onTabItem(int _selectedIndex) {
    _pageController.jumpToPage(_selectedIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused) {
      showBeforeIrrigationAlert();
      showAfterIrrigationAlert();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // drawer: openDrawerFromAnyWhere(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabItem,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: theme.accentColor),
            icon: Icon(Icons.home_outlined, color: Colors.grey),
            title: Text(
              'Home'.tr,
              style: TextStyle(color: theme.accentColor),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.store,
              color: theme.accentColor,
            ),
            icon: Icon(Icons.store_outlined, color: Colors.grey),
            title:
                Text('Market'.tr, style: TextStyle(color: theme.accentColor)),
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "asset/icons/agriculture-filled.svg",
              height: 25,
              width: 25,
              color: theme.accentColor,
            ),
            icon: SvgPicture.asset(
              "asset/icons/agriculture.svg",
              height: 25,
              width: 25,
              color: Colors.grey,
            ),
            title: Text('Crops'.tr, style: TextStyle(color: theme.accentColor)),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.email, color: theme.accentColor),
            icon: Icon(Icons.email_outlined, color: Colors.grey),
            title:
                Text('Message'.tr, style: TextStyle(color: theme.accentColor)),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.account_circle, color: theme.accentColor),
            icon: Icon(Icons.account_circle_outlined, color: Colors.grey),
            title:
                Text('Profile'.tr, style: TextStyle(color: theme.accentColor)),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: tabs,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Future showMyNotificationAsReminder() async {
    print("in");
    final time = irrigationTime.startTime!.split('')[0];
    var androidDetails = const fn.AndroidNotificationDetails(
        "Channel ID", "Zamindar",
        importance: fn.Importance.max);
    var generalNotificationDetails =
        fn.NotificationDetails(android: androidDetails);
    await notification.show(
        0,
        "یاد دہانی",
        "آج ${time} بجے آپ کو اپنے کھیت کو سیراب کرناہے۔",
        generalNotificationDetails,
        payload: "Task");
    print("out");
  }

  Future showMyNotificationAsAfterTime() async {
    print("in");
    final time = irrigationTime.startTime!.split('')[0];
    var androidDetails = const fn.AndroidNotificationDetails(
        "Channel ID", "Zamindar",
        importance: fn.Importance.max);
    var generalNotificationDetails =
        fn.NotificationDetails(android: androidDetails);
    await notification.show(0, "یاد دہانی",
        "کیا آپ نے اپنے کھیتوں کو سیراب کیا؟", generalNotificationDetails,
        payload: "Task");
    print("out");
  }

  void notificationSelected(String? payload) {}

  gotTapped() {
    final assetsAudioPlayer = AssetsAudioPlayer();
    try {
      assetsAudioPlayer.open(
        Audio("asset/music/click.mp3"),
      );
      // print("loaded");
    } catch (e) {
      print(e);
    }

    assetsAudioPlayer.play();
  }
}

openDrawerFromAnyWhere() {
  return mydrawer();
}
