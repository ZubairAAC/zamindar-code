import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/days.dart';
import 'package:zamindar/model/irrigationTime.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';

class irrigationTimeSelector extends StatefulWidget {
  irrigationTimeSelector({Key? key}) : super(key: key);

  @override
  _irrigationTimeSelectorState createState() => _irrigationTimeSelectorState();
}

class _irrigationTimeSelectorState extends State<irrigationTimeSelector> {
  int index = 2;
  String startDay = '';
  bool startDaySelected = false;
  late FixedExtentScrollController myscrollController;

  int timeindex = 2;
  String starttime = '';
  bool starttimeSelected = false;
  late FixedExtentScrollController myscrollControllerfortime;

  int endDayindex = 2;
  String endday = '';
  bool enddaySelected = false;
  late FixedExtentScrollController myscrollControllerforEndDay;

  int endTimeindex = 2;
  String endtime = '';
  bool endtimeSelected = false;
  late FixedExtentScrollController myscrollControllerforEndTime;

  @override
  void initState() {
    // TODO: implement initState
    myscrollController = FixedExtentScrollController(initialItem: index);
    myscrollControllerfortime =
        FixedExtentScrollController(initialItem: timeindex);
    myscrollControllerforEndDay =
        FixedExtentScrollController(initialItem: endDayindex);
    myscrollControllerforEndTime =
        FixedExtentScrollController(initialItem: endTimeindex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myscrollController.dispose();
    myscrollControllerfortime.dispose();
    myscrollControllerforEndDay.dispose();
    myscrollControllerforEndTime.dispose();
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
              "Select Time".tr,
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
              // Get.back();
              final start = startDay + ' ' + starttime.split(' ')[0];
              final end = endday + ' ' + endtime.split(' ')[0];
              final send = start + '-' + end;
              setState(() {
                irrigationTime.finalTime = send;
                irrigationTime.irrigationTimeSelected = true;
                setIsFarmSelectedFlag();
                setIrrigationTimeFlag();
              });
              setState(() {});
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(
                    "Done".tr,
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
        height: h * 0.50,
        margin: EdgeInsets.only(top: 30, left: 20, right: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: theme.cardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Select Irrigation Time".tr,
                          style: TextStyle(
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(height: h * 0.05),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [Text("Start Time".tr)],
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            myscrollController.dispose();
                            myscrollController =
                                FixedExtentScrollController(initialItem: index);
                            final mystartDay = await showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext bc) =>
                                    CupertinoActionSheet(
                                      message: Text(
                                        "Select day".tr,
                                        style: TextStyle(
                                            color: theme.primaryColorLight),
                                      ),
                                      cancelButton: CupertinoActionSheetAction(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "Cancel".tr,
                                            style: TextStyle(
                                                color: theme.accentColor),
                                          )),
                                      actions: [
                                        SizedBox(
                                          height: h * 0.25,
                                          child: CupertinoPicker(
                                              scrollController:
                                                  myscrollController,
                                              useMagnifier: true,
                                              backgroundColor:
                                                  theme.backgroundColor,
                                              itemExtent: 65,
                                              selectionOverlay:
                                                  CupertinoPickerDefaultSelectionOverlay(
                                                background: theme.accentColor
                                                    .withOpacity(0.2),
                                              ),
                                              onSelectedItemChanged: (e) {
                                                setState(() {
                                                  startDaySelected = true;
                                                  this.index = e;
                                                  startDay = days[e];
                                                  irrigationTime.startDay =
                                                      startDay;
                                                });
                                                // print(
                                                //     "start day is $startDay");
                                              },
                                              children: days
                                                  .map((e) => Center(
                                                        child: Text(
                                                          e,
                                                          style: TextStyle(
                                                              color: theme
                                                                  .primaryColorLight),
                                                        ),
                                                      ))
                                                  .toList()),
                                        )
                                      ],
                                    ));
                          },
                          child: Container(
                            height: h * 0.08,
                            width: w * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: theme.backgroundColor),
                            child: Center(
                              child:
                                  Text(startDaySelected ? startDay : "Day".tr),
                            ),
                          ),
                        ),
                        SizedBox(width: w * 0.05),
                        InkWell(
                            onTap: () {
                              myscrollControllerfortime.dispose();
                              myscrollControllerfortime =
                                  FixedExtentScrollController(
                                      initialItem: timeindex);
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext bc) =>
                                      CupertinoActionSheet(
                                        message: Text(
                                          "Select Time".tr,
                                          style: TextStyle(
                                              color: theme.primaryColorLight),
                                        ),
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  "Cancel".tr,
                                                  style: TextStyle(
                                                      color: theme.accentColor),
                                                )),
                                        actions: [
                                          SizedBox(
                                            height: h * 0.25,
                                            child: CupertinoPicker(
                                                scrollController:
                                                    myscrollControllerfortime,
                                                useMagnifier: true,
                                                backgroundColor:
                                                    theme.backgroundColor,
                                                selectionOverlay:
                                                    CupertinoPickerDefaultSelectionOverlay(
                                                  background: theme.accentColor
                                                      .withOpacity(0.2),
                                                ),
                                                itemExtent: 65,
                                                onSelectedItemChanged: (e) {
                                                  setState(() {
                                                    starttimeSelected = true;
                                                    this.index = e;
                                                    starttime = times[e];
                                                    irrigationTime.startTime =
                                                        starttime;
                                                  });
                                                },
                                                children: times
                                                    .map((e) => Center(
                                                          child: Text(
                                                            e,
                                                            style: TextStyle(
                                                                color: theme
                                                                    .primaryColorLight),
                                                          ),
                                                        ))
                                                    .toList()),
                                          )
                                        ],
                                      ));
                            },
                            child: Container(
                              height: h * 0.08,
                              width: w * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: theme.backgroundColor),
                              child: Center(
                                child: Text(
                                  starttimeSelected ? starttime : "Time".tr,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.08),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [Text("End Time".tr)],
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  InkWell(
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext bc) => CupertinoActionSheet(
                                message: Text(
                                  "Select day".tr,
                                  style:
                                      TextStyle(color: theme.primaryColorLight),
                                ),
                                cancelButton: CupertinoActionSheetAction(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      "Cancel".tr,
                                      style:
                                          TextStyle(color: theme.accentColor),
                                    )),
                                actions: [
                                  SizedBox(
                                    height: h * 0.25,
                                    child: CupertinoPicker(
                                        scrollController:
                                            myscrollControllerforEndDay,
                                        useMagnifier: true,
                                        backgroundColor: theme.backgroundColor,
                                        itemExtent: 65,
                                        selectionOverlay:
                                            CupertinoPickerDefaultSelectionOverlay(
                                          background: theme.accentColor
                                              .withOpacity(0.2),
                                        ),
                                        onSelectedItemChanged: (e) {
                                          setState(() {
                                            enddaySelected = true;
                                            this.index = e;
                                            endday = days[e];
                                            irrigationTime.endDay = endday;
                                          });
                                        },
                                        children: days
                                            .map((e) => Center(
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(
                                                        color: theme
                                                            .primaryColorLight),
                                                  ),
                                                ))
                                            .toList()),
                                  )
                                ],
                              ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: h * 0.08,
                            width: w * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: theme.backgroundColor),
                            child: Center(
                              child: Text(enddaySelected ? endday : "Day".tr),
                            ),
                          ),
                          SizedBox(width: w * 0.05),
                          InkWell(
                              onTap: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext bc) =>
                                        CupertinoActionSheet(
                                          message: Text(
                                            "Select Time".tr,
                                            style: TextStyle(
                                                color: theme.primaryColorLight),
                                          ),
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Cancel".tr,
                                                    style: TextStyle(
                                                        color:
                                                            theme.accentColor),
                                                  )),
                                          actions: [
                                            SizedBox(
                                              height: h * 0.25,
                                              child: CupertinoPicker(
                                                  scrollController:
                                                      myscrollControllerforEndTime,
                                                  useMagnifier: true,
                                                  backgroundColor:
                                                      theme.backgroundColor,
                                                  selectionOverlay:
                                                      CupertinoPickerDefaultSelectionOverlay(
                                                    background: theme
                                                        .accentColor
                                                        .withOpacity(0.2),
                                                  ),
                                                  itemExtent: 65,
                                                  onSelectedItemChanged: (e) {
                                                    setState(() {
                                                      endtimeSelected = true;
                                                      this.index = e;
                                                      endtime = times[e];
                                                      irrigationTime.endTime =
                                                          endtime;
                                                    });
                                                  },
                                                  children: times
                                                      .map((e) => Center(
                                                            child: Text(
                                                              e,
                                                              style: TextStyle(
                                                                  color: theme
                                                                      .primaryColorLight),
                                                            ),
                                                          ))
                                                      .toList()),
                                            )
                                          ],
                                        ));
                              },
                              child: Container(
                                height: h * 0.08,
                                width: w * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: theme.backgroundColor),
                                child: Center(
                                  child: Text(
                                      endtimeSelected ? endtime : "Time".tr),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
