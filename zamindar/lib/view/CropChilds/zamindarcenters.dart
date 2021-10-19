import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/location_service.dart';

class zamindarCenter extends StatefulWidget {
  zamindarCenter({Key? key}) : super(key: key);

  @override
  _zamindarCenterState createState() => _zamindarCenterState();
}

class _zamindarCenterState extends State<zamindarCenter> {
  bool diplay = true;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        diplay = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: theme.accentColor,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Zamindar Center".tr,
              style: TextStyle(color: theme.primaryColorLight, fontSize: 18),
            )
          ],
        ),
      ),
      body: diplay
          ? Center(
              child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.cardColor),
              child: Center(
                child: Text(
                  "Getting your Location data ...".tr,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ))
          : Column(
              children: [
                Divider(
                  color: theme.accentColor,
                ),
                Spacer(),
                Container(
                  child: Column(
                    children: [
                      Text("Currently we dont operate in your area".tr),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          print(UserLocation.street);
                        },
                        splashColor: theme.cardColor,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: theme.accentColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Request".tr,
                              style: TextStyle(
                                  color: theme.cardColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
    );
  }

  startScreen() {
    Visibility(
      visible: diplay,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
