import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:zamindar/view/Supporting%20Screens/AboutView.dart';
import 'package:zamindar/view/Supporting%20Screens/Terms&PoliciesView.dart';
import 'package:zamindar/view/widgets/ContactUs.dart';
import 'package:zamindar/view/widgets/RateUs.dart';

class MySetting extends StatefulWidget {
  MySetting({Key? key}) : super(key: key);

  @override
  _MySettingState createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.backgroundColor,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 330,
            color: theme.cardColor,
            child: Column(
              children: [
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Get.to(() => AboutZamindar());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "asset/icons/info.svg",
                          color: theme.accentColor,
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "About Zamindar".tr,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "asset/icons/global.svg",
                          color: theme.accentColor,
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Change Language".tr,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => TermsView());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "asset/icons/lock.svg",
                          color: theme.accentColor,
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Terms & Policies".tr,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return rateMe();
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "asset/icons/star.svg",
                          color: theme.accentColor,
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Rate us".tr,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return contactme();
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "asset/icons/email.svg",
                          color: theme.accentColor,
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Contact us".tr,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
              color: theme.accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Logout".tr,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    updateLocale(Locale locale, BuildContext context) async {
      Get.updateLocale(locale);
      // await setLocale(locale);
    }

    // set up the button
    final theme = Theme.of(context);

    Widget closeButton = IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: theme.accentColor,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: SvgPicture.asset(
              "asset/icons/close.svg",
              color: Colors.white,
              height: 7,
              width: 7,
            ))));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        margin: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 190,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              child: Row(
                children: [
                  Spacer(),
                  closeButton,
                ],
              ),
            ),
            Text(
              "Change Language",
              style: TextStyle(fontSize: 18),
            ),
            InkWell(
              onTap: () {
                updateLocale(Locale("en_US"), context);
                Get.back();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(right: 20, top: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text("English"),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                updateLocale(Locale("ur_PK"), context);
                Get.back();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(right: 20, top: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text("اردو"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      elevation: 0.0,
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // actions: [
      //   closeButton,
      // ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
