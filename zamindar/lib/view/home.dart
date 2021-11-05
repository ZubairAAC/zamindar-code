// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zamindar/model/homePageData.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zamindar/model/info.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/HomeChilds/ask.dart';
import 'package:zamindar/view/HomeChilds/PostView.dart';
import 'package:zamindar/view/HomeChilds/notification.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view_model/getInfo.dart';
import 'package:zamindar/view_model/internetChecker.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';
import 'package:zamindar/view_model/sqfliteDb.dart';
import 'package:zamindar/view_model/userLocation.dart';

import 'HomeChilds/weatherView.dart';

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
  bool hasInternet = true;
  late Future<List<Info>> getMydata;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    // locationService();
    getMydata = getInfoFromApi();
    super.initState();

    // ignore: unnecessary_new
    _controller = new TabController(length: 2, vsync: this);
    getlocation();
    checkInternet();
    locationFinder().createState().locationService();

    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      print("=====================>${this.hasInternet}<====================");
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
    connectivityChecker();
    getIsLoginFlag();
    getUserInfoFromDB();
  }

  getUserInfoFromDB() async {
    // List<Map<String, dynamic>> myinfo = [];
    List myinfo = await UserDB.getItems();
    setState(() {
      user.name = myinfo[0]['name'];
      user.id = myinfo[0]['id'];
      user.gender = myinfo[0]['gender'];
      user.image = myinfo[0]['image'];
      user.phone = myinfo[0]['phone'];
    });
    // print(user.id);
    // print(user.name);
    // print(user.gender);
    // print(user.phone);
    // print(user.image);
  }

  getlocation() async {
    try {
      print(UserLocation.lat);
      print(UserLocation.long);
      List<Placemark> placemark =
          await placemarkFromCoordinates(UserLocation.lat, UserLocation.long);
      setState(() {
        UserLocation.street = placemark[0].street!;
        print(UserLocation.street);
      });
    } on PlatformException catch (e) {
      print("=======>$e<=====================");
    }
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
            user.userlogin
                ? IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: theme.iconTheme.color,
                    ),
                    onPressed: () {
                      Get.to(() => NotificationScreen());
                    },
                  )
                : Container()
          ],
        ),
        // ignore: prefer_const_constructors
        drawer: openDrawerFromAnyWhere(),
        body: hasInternet
            ? SingleChildScrollView(
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
                            Get.to(() => Ask());
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
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
                FutureBuilder<List<Info>>(
                  future: getMydata,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        baseColor: theme.cardColor,
                        highlightColor: theme.backgroundColor,
                        child: Container(
                          height: 300,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                padding: EdgeInsets.all(20),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Container(
                        child: Text("something went wrong"),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final data = snapshot.data![index];
                          return InkWell(
                            onTap: () async {
                              Get.to(() => PostView(
                                    title: data.title,
                                    description: data.description,
                                    img: data.image,
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 5, bottom: 5),
                              height: 300,
                              decoration: BoxDecoration(
                                  color: theme.cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: theme.backgroundColor)),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Container(
                                    height: 50,
                                    // color: Colors.red,
                                    padding: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
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
                                          margin: EdgeInsets.only(right: 5),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Zamindar",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 8),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "60 mints ago",
                                                    style:
                                                        TextStyle(fontSize: 5),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                  child: Text(data.title,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 238,
                                    decoration: BoxDecoration(
                                        // color: theme.accentColor,
                                        border: Border.all(
                                            color: Color(0xFF707070)
                                                .withOpacity(0.30)),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      child: Image.memory(
                                        base64Decode(data.image),
                                        height: 238,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: theme.accentColor,
                        ),
                      );
                    }
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
                                final url =
                                    'https://www.instagram.com/zaamindaar/';
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
              ])))
            : Container(
                child: Center(
                  child: Text("No Internet"),
                ),
              ));
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
