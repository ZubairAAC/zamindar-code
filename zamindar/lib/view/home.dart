// ignore_for_file: prefer_const_constructors

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zamindar/model/homePageData.dart';
import 'package:zamindar/view/Supporting%20Screens/PostView.dart';
import 'package:zamindar/view/Supporting%20Screens/askQuestion.dart';
import 'package:zamindar/view/Supporting%20Screens/notification.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view/widgets/drawer.dart';

import 'Supporting Screens/weatherView.dart';

// ignore: camel_case_types
class mainHome extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  mainHome({Key? key}) : super(key: key);

  @override
  _mainHomeState createState() => _mainHomeState();
}

// ignore: camel_case_types
class _mainHomeState extends State<mainHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // ignore: unnecessary_new
    _controller = new TabController(length: 2, vsync: this);
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: theme.backgroundColor,
          leading: Builder(builder: (BuildContext context) {
            // ignore: deprecated_member_use
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
              onPressed: () {
                Get.to(() => NotificationScreen());
              },
            )
          ],
        ),
        // ignore: prefer_const_constructors
        drawer: openDrawerFromAnyWhere(),
        body: SingleChildScrollView(
            // ignore: avoid_unnecessary_containers
            child: Container(
                child: Column(children: [
          Container(
            height: 85,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.18,
            ),
            decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                )),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // ignore: avoid_print
                    print(index);
                    if (index == 0) {
                      Get.to(() => AskQuestion());
                    } else if (index == 1) {
                      Get.to(() => WeatherView());
                    } else if (index == 2 || index == 3) {
                      gotUpdated();
                      Get.snackbar("Comming Soon",
                          'This Feature is commong soon. Stay Tunned to get updated',
                          backgroundColor: theme.backgroundColor);
                    }

                    // Get.to(HomeNames[index][1]);
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              HomeImages[index],
                              height: 20,
                              width: 20,
                              // ignore: deprecated_member_use
                              color: theme.accentColor,
                            ),
                            SizedBox(height: 5),
                            Text(
                              HomeIcons[index].tr,
                              style: TextStyle(fontSize: 8),
                              overflow: TextOverflow.ellipsis,
                            )
                          ])),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print(index);
                  Get.to(() => PostView());
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  height: 300,
                  decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: theme.backgroundColor)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        // color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Image.asset(
                                    "asset/logo/splash.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 265,
                              // color: Colors.blue,
                              margin: EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Zamindar",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "60 mints ago",
                                        style: TextStyle(fontSize: 5),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                      child: Text(
                                          "This is sample text for the post of agri info in zamindar app specialy designed for farmers community in Pakistan",
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 10),
                                          overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 238,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                                color: Color(0xFF707070).withOpacity(0.30)),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Find us".tr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          final url = 'https://facebook.com/zaamindaar';
                          if (await canLaunch(url)) {
                            await launch(url,
                                forceSafariVC: false,
                                forceWebView: false,
                                enableJavaScript: false);
                          } else {
                            print("cant launch");
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            "asset/icons/fb.svg",
                            height: 5,
                            width: 5,
                            color: theme.accentColor,
                          ),
                        ),
                      ),
                      // SizedBox(width: 5),
                      InkWell(
                        onTap: () async {
                          final url = 'https://www.instagram.com/zaamindaar/';
                          if (await canLaunch(url)) {
                            await launch(url,
                                forceSafariVC: false,
                                forceWebView: false,
                                enableJavaScript: false);
                          } else {
                            print("cant launch");
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            // color: theme.accentColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            "asset/icons/insta.svg",
                            height: 15,
                            width: 15,
                            color: theme.accentColor,
                          ),
                        ),
                      ),
                      // SizedBox(width: 5),
                      InkWell(
                        onTap: () async {
                          final url =
                              'https://www.linkedin.com/company/zaamindaar';
                          if (await canLaunch(url)) {
                            await launch(url,
                                forceSafariVC: false,
                                forceWebView: false,
                                enableJavaScript: false);
                          } else {
                            print("cant launch");
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            // color: theme.accentColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            "asset/icons/linkedin.svg",
                            height: 15,
                            width: 15,
                            color: theme.accentColor,
                          ),
                        ),
                      ),
                      // SizedBox(width: 5),
                      InkWell(
                        onTap: () async {
                          final url = 'https://twitter.com/zaamindaar';
                          if (await canLaunch(url)) {
                            await launch(url,
                                forceSafariVC: false,
                                forceWebView: false,
                                enableJavaScript: false);
                          } else {
                            print("cant launch");
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            // color: theme.accentColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            "asset/icons/twitter.svg",
                            height: 15,
                            width: 15,
                            color: theme.accentColor,
                          ),
                        ),
                      ),
                      // SizedBox(width: 5),
                      InkWell(
                        onTap: () async {
                          final url =
                              'https://www.youtube.com/channel/UCnK_NLzsOM4t0pnhPIJoF2A';
                          if (await canLaunch(url)) {
                            await launch(url,
                                forceSafariVC: false,
                                forceWebView: false,
                                enableJavaScript: false);
                          } else {
                            print("cant launch");
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            // color: theme.accentColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            "asset/icons/yt.svg",
                            height: 10,
                            width: 10,
                            color: theme.accentColor,
                          ),
                        ),
                      ),
                      // SizedBox(width: 5),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
        ]))));
  }

  gotUpdated() {
    final assetsAudioPlayer = AssetsAudioPlayer();
    try {
      assetsAudioPlayer.open(
        Audio("asset/music/update.wav"),
      );
      // print("loaded");
    } catch (e) {
      print(e);
    }

    assetsAudioPlayer.play();
  }
}
