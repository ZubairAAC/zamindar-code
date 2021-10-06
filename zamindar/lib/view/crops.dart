// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/CropsData.dart';

// ignore: camel_case_types
class crops extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  crops({Key? key}) : super(key: key);

  @override
  _cropsState createState() => _cropsState();
}

// ignore: camel_case_types
class _cropsState extends State<crops> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        body: SingleChildScrollView(
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
                itemBuilder: (BuildContext context, int index) {
                  return Container(
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
                      ));
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: theme.cardColor,
              child: Text("Weather data in your Village"),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                  );
                },
              ),
            )
          ]),
        )));
  }
}
