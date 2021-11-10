import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zamindar/model/city.dart';
import 'package:zamindar/view/MarketChild/callDailogue.dart';
import 'package:zamindar/view/MessageChild/inchat.dart';

class MarketAdView extends StatefulWidget {
  String adtitle;
  String adcategory;
  String adcity;
  String addescription;
  String adperson;
  String adphoto;
  String adphone;
  String myicon;
  MarketAdView(
      {Key? key,
      required this.adtitle,
      required this.adcategory,
      required this.adcity,
      required this.addescription,
      required this.adperson,
      required this.adphone,
      required this.myicon,
      required this.adphoto})
      : super(key: key);

  @override
  _MarketAdViewState createState() => _MarketAdViewState(adcategory, adcity,
      addescription, adperson, adphone, adphoto, adtitle, myicon);
}

class _MarketAdViewState extends State<MarketAdView> {
  String adtitle;
  String adcategory;
  String adcity;
  String addescription;
  String adperson;
  String adphoto;
  String adphone;
  String myicon;

  _MarketAdViewState(
      this.adtitle,
      this.adcategory,
      this.adcity,
      this.addescription,
      this.adperson,
      this.adphone,
      this.adphoto,
      this.myicon);
  var cityName;

  @override
  void initState() {
    super.initState();
    // print("title: $adtitle");
    // print("description: $addescription");
    // print("category: $adcategory");
    // print("city: $adcity");
    // print("person: $adperson");
    // print("photo: $adphoto");
    // print("phone: $adphone");
    // print("icon: $myicon");
    // print(adcategory.substring(
    //   0,
    // ));
    var first = RegExp('[a-zA-Z]');
    var second = adcategory.replaceAll(first, "");
    cityName = second.replaceAll(": ", "");
    print(cityName);

    // print(adcategory.split(":"));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 350,
                padding: EdgeInsets.only(top: 20, right: 0, left: 0),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 27,
                              width: 38,
                              decoration: BoxDecoration(
                                color: theme.accentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: theme.primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                          // color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Row(
                        children: [
                          Text(
                            adphoto,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Details".tr,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 114,
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.28,
                            decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                SvgPicture.asset(
                                  myicon,
                                  height: 30,
                                  width: 30,
                                  color: theme.accentColor,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  adtitle.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: theme.accentColor),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Category".tr,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.28,
                            decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(
                                  Icons.location_city_outlined,
                                  size: 30,
                                  color: theme.accentColor,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  cityName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: theme.accentColor,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  ),
                                ),
                                // SizedBox(height: 5),
                                Text("City".tr, style: TextStyle(fontSize: 15)),
                                SizedBox(height: 3)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.28,
                            decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                SvgPicture.asset(
                                  'asset/icons/calendar_today_black_24dp.svg',
                                  height: 30,
                                  width: 30,
                                  color: theme.accentColor,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "31-12-2021",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: theme.accentColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text("Date".tr),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Description".tr,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        adcity,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Contact Person".tr,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 105,
                      decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            height: 105,
                            width: 100,
                            decoration: BoxDecoration(
                                // color: theme.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: theme.backgroundColor)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                base64Decode(adphone),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 205,
                            // color: Colors.red,
                            margin:
                                EdgeInsets.only(left: 10, right: 5, top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  addescription,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  // color: Colors.blue,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return call(
                                                adphone: adperson,
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: theme.backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                size: 15,
                                                color: theme.accentColor,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Call".tr,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => inChat());
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: theme.backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.email_outlined,
                                                size: 15,
                                                color: theme.accentColor,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Message".tr,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

findIcon(String category) {
  switch (category) {
    case 'Plants':
      return "asset/icons/plant.svg";
      break;
    case 'Cattles':
      return "asset/icons/cow.svg";
      break;
    case 'Machinery':
      return "asset/icons/tractor.svg";
      break;
    case 'Services':
      return "asset/icons/shovel.svg";
      break;

    default:
      "asset/icons/plant.svg";
  }
}
