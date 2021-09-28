import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zamindar/provider/theme.dart';
import 'package:zamindar/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.backgroundColor,
        leading: Builder(builder: (BuildContext context) {
          return FlatButton(
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              child: SvgPicture.asset(
                "asset/icons/drawerIcon.svg",
                color: theme.iconTheme.color,
                height: 20,
                width: 20,
              ));
        }),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: theme.iconTheme.color,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: mydrawer(),
      bottomNavigationBar: BottomNavigationBar(
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
              title:
                  Text('Crops'.tr, style: TextStyle(color: theme.accentColor)),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.email, color: theme.accentColor),
              icon: Icon(Icons.email_outlined, color: Colors.grey),
              title: Text('Message'.tr,
                  style: TextStyle(color: theme.accentColor)),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_circle, color: theme.accentColor),
              icon: Icon(Icons.account_circle_outlined, color: Colors.grey),
              title: Text('Profile'.tr,
                  style: TextStyle(color: theme.accentColor)),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              gotTapped();
            });
          }),
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
