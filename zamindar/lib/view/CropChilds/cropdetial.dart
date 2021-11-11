import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/irrigationTime.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:zamindar/view/CropChilds/irrigationTimeSelection.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';

class CropDetails extends StatefulWidget {
  CropDetails({Key? key}) : super(key: key);

  @override
  _CropDetailsState createState() => _CropDetailsState();
}

class _CropDetailsState extends State<CropDetails> {
  int _groupValue = -1;
  bool timeSelected = false;

  @override
  void initState() {
    super.initState();
    timeSelected = irrigationTime.irrigationTimeSelected;
    String lat = "${UserLocation.lat}";
    String long = "${UserLocation.long}";

    setFarmLocationFlag(UserLocation.lat, UserLocation.long);
    setState(() {});
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
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: theme.accentColor)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add Details".tr,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorLight),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.offAll(() => HomeScreen());
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(
                    "Next".tr,
                    style:
                        TextStyle(fontSize: 15, color: theme.primaryColorLight),
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    "asset/icons/right-arrow.svg",
                    height: 15,
                    width: 15,
                    color: theme.accentColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Divider(
              // ignore: deprecated_member_use
              color: theme.accentColor,
            ),
            SizedBox(height: h * 0.04),
            Container(
              height: h * 0.61,
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Zamindar Farming Tips".tr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: w * 0.05, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  Row(
                    children: [
                      Text(
                        "To get daily updates on your crops add details".tr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: w * 0.03, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.02),
                  InkWell(
                    onTap: () {
                      Get.to(() => irrigationTimeSelector());
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return DateTimePickerForCrop();
                      //   },
                      // );
                    },
                    child: Container(
                      height: h * 0.10,
                      decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: theme.accentColor,
                            size: 20,
                          ),
                          SizedBox(width: w * 0.03),
                          Text(
                            irrigationTime.irrigationTimeSelected
                                ? irrigationTime.finalTime
                                : "Select Irrigation time >".tr,
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.bold,
                                color: theme.accentColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Container(
                    height: h * 0.33,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "asset/icons/water-well.svg",
                              height: h * 0.03,
                              width: w * 0.03,
                              color: theme.accentColor,
                            ),
                            SizedBox(width: w * 0.03),
                            Text("Select Irrigation Type".tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: theme.accentColor)),
                            SizedBox(width: w * 0.05),
                          ],
                        ),
                        SizedBox(height: h * 0.03),
                        Container(
                          height: h * 0.08,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Radio(
                                  activeColor: theme.accentColor,
                                  value: 0,
                                  groupValue: _groupValue,
                                  onChanged: (e) {
                                    setState(() {
                                      _groupValue = e as int;
                                    });
                                  }),
                              SizedBox(width: w * 0.01),
                              Text(
                                "Canal Irrigation".tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: h * 0.015),
                        Container(
                          padding: EdgeInsets.all(20),
                          height: h * 0.08,
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Radio(
                                  activeColor: theme.accentColor,
                                  value: 1,
                                  groupValue: _groupValue,
                                  onChanged: (e) {
                                    setState(() {
                                      _groupValue = e as int;
                                    });
                                  }),
                              SizedBox(width: w * 0.01),
                              Text(
                                "Tube Well Irrigation".tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
    );
  }
}
