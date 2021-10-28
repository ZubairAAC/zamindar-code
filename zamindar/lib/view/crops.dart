// ignore_for_file: prefer_const_constructors

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:zamindar/model/CropsData.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/CropChilds/CropManuals.dart';
import 'package:zamindar/view/CropChilds/fertiliserCalculator.dart';
import 'package:zamindar/view/CropChilds/addfarms.dart';
import 'package:zamindar/view/CropChilds/cropSelection.dart';
import 'package:zamindar/view/CropChilds/zamindarcenters.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view_model/internetChecker.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';
import 'package:zamindar/view_model/weatherApiCall.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class crops extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  crops({Key? key}) : super(key: key);

  @override
  _cropsState createState() => _cropsState();
}

// ignore: camel_case_types
class _cropsState extends State<crops> {
  bool _isvisible = true;
  bool farmSelected = false;
  @override
  void initState() {
    connectivityChecker(); // TODO: implement initState
    super.initState();
    getfarm();
    loadWeather();
  }

  loadWeather() async {
    if (UserLocation.lat != null && UserLocation.long != null) {
      final today = DateFormat('EEEE').format(DateTime.now());

      print(
          "accessing weather for location ====> ${UserLocation.lat}  & ${UserLocation.long}");
      print("today is ====>${today}");
      // weatherApi(UserLocation.lat, UserLocation.long);
    }
    print("location not access able");
    return;
  }

  getfarm() async {
    final v = await getIsFarmSelectedFlag();
    setState(() {
      farmSelected = v;
    });

    print(farmSelected);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Crops".tr,
                  style: TextStyle(
                      // ignore: deprecated_member_use
                      color: theme.accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        body: user.userlogin
            ? SingleChildScrollView(
                child: Container(
                // ignore: prefer_const_constructors
                margin: EdgeInsets.only(bottom: 50),
                child: Column(children: [
                  Divider(
                    // ignore: deprecated_member_use
                    color: theme.accentColor,
                  ),
                  Container(
                    height: 85,
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.55,
                    ),
                    decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        )),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (index == 0) {
                              Get.to(() => CropSelection());
                            } else if (index == 1) {
                              Get.to(() => addFarms());
                            }
                          },
                          child: Visibility(
                            visible: _isvisible,
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
                                      ScrolImages[index],
                                      height: 20,
                                      width: 20,
                                      // ignore: deprecated_member_use
                                      color: theme.accentColor,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      ScrolNames[index].tr,
                                      style: TextStyle(fontSize: 8),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: farmSelected,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Weather in your Farms",
                                overflow: TextOverflow.ellipsis,
                              )),
                          SizedBox(height: 5),
                          SizedBox(
                            height: 125,
                            child: UserLocation.lat != null &&
                                    UserLocation.long != null
                                ? ListView.builder(
                                    itemCount: 7,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        child: Container(
                                          width: h * 0.12,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: theme.cardColor,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                          )
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   itemCount: 7,
                          //   scrollDirection: Axis.horizontal,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return Container();
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 240,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            print(index);
                            if (index == 0) {
                              Get.to(() => Calculator());
                            }
                            if (index == 1) {
                              Get.to(() => CropManuals());
                            }
                            if (index == 2) {
                              Get.to(() => zamindarCenter());
                            }
                            if (index == 3 || index == 4 || index == 5) {
                              gotUpdated();
                              Get.snackbar("Comming Soon",
                                  'This Feature is commong soon. Stay Tunned to get updated',
                                  backgroundColor: theme.backgroundColor);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            height: 5,
                            width: 5,
                            // color: theme.accentColor,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    CropFeatureImages[index],
                                    height: 50,
                                    width: 50,
                                    // ignore: deprecated_member_use
                                    color: theme.accentColor,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    CropFeatureName[index].tr,
                                    style: TextStyle(fontSize: 10),
                                  )
                                ]),
                          ),
                        );
                      },
                    ),
                  )
                ]),
              ))
            : Container(
                child: Center(
                  child: Text("Please Login to see".tr),
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
