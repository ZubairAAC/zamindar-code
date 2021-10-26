import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/crops.dart';
import 'package:zamindar/view/home.dart';
import 'package:zamindar/view/market.dart';
import 'package:zamindar/view/message.dart';
import 'package:zamindar/view/profile.dart';
import 'package:zamindar/view/widgets/LoginChecker.dart';
import 'package:zamindar/view/widgets/drawer.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getIsLoginFlag();
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
