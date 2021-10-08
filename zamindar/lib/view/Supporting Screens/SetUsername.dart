import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:zamindar/view/parent/myhome.dart';

class SetProfile extends StatefulWidget {
  SetProfile({Key? key}) : super(key: key);

  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Set Profile",
              style: TextStyle(
                  color: theme.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 175,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 175,
                        width: 175,
                        decoration: BoxDecoration(
                          color: theme.accentColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: theme.accentColor,
                              radius: 175,
                              child: Icon(
                                Icons.person,
                                color: theme.cardColor,
                                size: 120,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: theme.accentColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: theme.cardColor, width: 3)),
                                child: Icon(
                                  Icons.create,
                                  size: 15,
                                  color: theme.cardColor,
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextField(
                        cursorColor: theme.accentColor,
                        decoration: InputDecoration(
                            hintText: "Enter Your Name here".tr,
                            labelText: 'Name'.tr,
                            fillColor: theme.cardColor,
                            filled: true,
                            isDense: true,
                            labelStyle: TextStyle(color: theme.accentColor),
                            hintStyle: TextStyle(fontSize: 15),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: theme.accentColor,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: theme.accentColor, width: 2))),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 125,
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: theme.accentColor, width: 2)),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [Text("What is your Gender?")],
                              ),
                            ),
                            SizedBox(height: 3),
                            Container(
                              height: 70,
                              // color: Colors.red,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: theme.backgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: theme.accentColor, width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Male",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: theme.backgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: theme.accentColor, width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Female",
                                        style: TextStyle(fontSize: 12),
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
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              InkWell(
                splashColor: theme.cardColor,
                hoverColor: theme.cardColor,
                focusColor: theme.cardColor,
                onTap: () {
                  Get.offAll(() => HomeScreen());
                },
                child: Center(
                    child: Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width * 0.70,
                  decoration: BoxDecoration(
                    color: theme.accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Continue".tr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
