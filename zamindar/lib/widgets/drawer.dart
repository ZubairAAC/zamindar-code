import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:zamindar/provider/theme.dart';

class mydrawer extends StatelessWidget {
  const mydrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final ColorScheme mycolorScheme = theme.colorScheme;

    return SafeArea(
      child: Container(
          padding: EdgeInsets.only(bottom: 15),
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
          ),
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50.0))),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      foregroundImage: AssetImage('asset/icons/logo.png'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Zamindar".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Farmer of new era".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 8),
                  )
                ],
              )),
            ),
            // SizedBox(height: 20),
            Container(
                // height: MediaQuery.of(context).size.height * 0.55,
                // color: Colors.red,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    buildMenuItem(
                        iconcolor: theme.accentColor,
                        text: "How App Work".tr,
                        assetName: "asset/icons/play-button.svg"),
                    buildMenuItem(
                        iconcolor: theme.accentColor,
                        text: "Chat With Zamindar".tr,
                        assetName: "asset/icons/chat.svg"),
                    buildMenuItem(
                        iconcolor: theme.accentColor,
                        text: "Rate & Feedback".tr,
                        assetName: "asset/icons/star.svg"),
                    buildMenuItem(
                        onClicked: () {
                          Navigator.pop(context, true);
                          Get.defaultDialog(
                              title: "Please Select your preferred language".tr,
                              titleStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: theme.iconTheme.color,
                              ),
                              backgroundColor: theme.backgroundColor,
                              content: Column(children: [
                                InkWell(
                                  onTap: () {
                                    print("english");
                                    updateLocale(Locale("en_US"), context);
                                    Get.back();
                                  },
                                  child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: theme.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                          title: Text(
                                        "English",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: theme.iconTheme.color),
                                      ))),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    print("urdu");
                                    updateLocale(Locale("ur_PK"), context);
                                    Get.back();
                                  },
                                  child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: theme.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                          title: Text(
                                        "اُردو",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: theme.iconTheme.color),
                                      ))),
                                ),
                              ]),
                              radius: 10);
                        },
                        iconcolor: theme.accentColor,
                        text: "Change Language".tr,
                        assetName: "asset/icons/global.svg"),

                    buildMenuItem(
                        iconcolor: theme.accentColor,
                        text: "Invite Friends".tr,
                        assetName: "asset/icons/invite.svg"),
                    buildMenuItem(
                        iconcolor: theme.accentColor,
                        text: "Share Zamindar App".tr,
                        assetName: "asset/icons/share.svg"),
                    buildMenuItem(
                        iconcolor: theme.accentColor,
                        text: "Suggestion".tr,
                        assetName: "asset/icons/bulb.svg"),
                    buildMenuItem(
                        iconcolor: theme.accentColor,
                        text: "Become Supporter".tr,
                        assetName: "asset/icons/superhero.svg"),
                    buildMenuItem(
                        iconcolor: theme.accentColor,
                        text: "My Village".tr,
                        assetName: "asset/icons/neighborhood.svg"),
                    buildMenuItem(
                        onClicked: () {
                          Navigator.pop(context, true);
                          Get.defaultDialog(
                              title:
                                  "Please Select your preferred app appearance"
                                      .tr,
                              titleStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: theme.iconTheme.color,
                              ),
                              backgroundColor: theme.backgroundColor,
                              content: Column(children: [
                                InkWell(
                                  onTap: () {
                                    currentTheme.toggleTheme();
                                    Get.back();
                                  },
                                  child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: theme.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                          leading: Icon(Icons.light_mode,
                                              size: 20,
                                              color: theme.iconTheme.color),
                                          title: Text(
                                            "Light Mode".tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: theme.iconTheme.color),
                                          ))),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    currentTheme.toggleTheme();
                                    Get.back();
                                  },
                                  child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: theme.cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                          leading: Icon(Icons.dark_mode,
                                              size: 20,
                                              color: theme.iconTheme.color),
                                          title: Text(
                                            "Dark Mode".tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: theme.iconTheme.color),
                                          ))),
                                ),
                              ]),
                              radius: 10);
                        },
                        iconcolor: theme.accentColor,
                        text: "App Apearance".tr,
                        assetName: "asset/icons/color scheme.svg"),
                    // Spacer(),
                    // Spacer(),
                  ],
                )),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text("Made in Pakistan With"),
                  SizedBox(width: 5),
                  Icon(
                    Icons.favorite,
                    size: 20,
                    color: theme.iconTheme.color,
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Zamindar V1.0",
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.normal),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      "All rights are reserved",
                      style: TextStyle(
                          // color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            )
          ])),
    );
  }

  updateLocale(Locale locale, BuildContext context) async {
    Get.updateLocale(locale);
    // await setLocale(locale);
  }
}

Widget buildMenuItem({
  required String text,
  // required SvgPicture myicon,
  final String assetName = 'asset/icons/',
  required final Color iconcolor,
  VoidCallback? onClicked,
}) {
  return InkWell(
    onTap: onClicked,
    child: Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            assetName,
            color: iconcolor,
            height: 20,
            width: 20,
          ),
          SizedBox(width: 10),
          Text(
            text,
          )
        ],
      ),
    ),
  );
}
