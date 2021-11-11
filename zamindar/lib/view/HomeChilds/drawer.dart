import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zamindar/view/widgets/RateUs.dart';
import 'package:zamindar/view/widgets/colorswitcher.dart';

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
                  SizedBox(height: 7),
                  Text(
                    "Zamindar".tr,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Farmer of new era".tr,
                    overflow: TextOverflow.ellipsis,
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
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    buildMenuItem(
                        onClicked: () async {
                          Get.back();
                          final url =
                              'https://www.youtube.com/channel/UCnK_NLzsOM4t0pnhPIJoF2A';
                          if (await canLaunch(url)) {
                            await launch(url,
                                enableJavaScript: true,
                                forceSafariVC: true,
                                forceWebView: true);
                          }
                        },
                        iconcolor: theme.accentColor,
                        text: "How App Work".tr,
                        assetName: "asset/icons/play-button.svg"),

                    // buildMenuItem(
                    //     iconcolor: theme.accentColor,
                    //     text: "Chat With Zamindar".tr,
                    //     assetName: "asset/icons/chat.svg"),
                    buildMenuItem(
                        onClicked: () {
                          Get.back();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return rateMe();
                            },
                          );
                        },
                        iconcolor: theme.accentColor,
                        text: "Rate & Feedback".tr,
                        assetName: "asset/icons/star.svg"),
                    buildMenuItem(
                        onClicked: () {
                          Navigator.pop(context, true);
                          showAlertDialog(context);
                        },
                        iconcolor: theme.accentColor,
                        text: "Change Language".tr,
                        assetName: "asset/icons/global.svg"),

                    buildMenuItem(
                        onClicked: () async {
                          final one = 'کیا آپ نے اس ایپ کو چیک کیا ہے؟';
                          final two =
                              'یہ کسانوں کی ایپ ہے جس کا نام زمیندار ہے۔';
                          final three = 'مجھے یہ بہت مفید لگتا ہے۔';
                          final four =
                              'آپ ہزاروں کسانوں کی کمیونٹی میں بھی شامل ہو سکتے ہیں۔';
                          final five = 'ان کا سوشل میڈیا چیک کریں۔';
                          final fb = 'https://facebook.com/zaamindaar';
                          final tw = 'https://twitter.com/zaamindaar';
                          final ig = 'https://www.instagram.com/zaamindaar/';
                          final ld =
                              'https://www.linkedin.com/company/zaamindaar';
                          final six = 'ان کی ویب سائٹ چیک کریں';
                          final sven = 'https://zaamindaar.com';

                          final finals =
                              "$one \n $two $three \n $four \n$five \n\n$fb\n$tw\n$ig\n$ld\n$six\n$sven";

                          Get.back();
                          Share.share(finals);

                          // Share.shareFiles(path, text: finals);
                        },
                        iconcolor: theme.accentColor,
                        text: "Share Zamindar App".tr,
                        assetName: "asset/icons/share.svg"),
                    buildMenuItem(
                        onClicked: () async {
                          Get.back();
                          final toEmail = 'info@zaamindaar.com';
                          final subject = 'Ive suggestions about this App';
                          final message =
                              'Hi there \nGreetings\nI have some suggestions about this app';
                          final url =
                              'mailto:$toEmail?subject=${subject}&body=${message}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                        iconcolor: theme.accentColor,
                        text: "Suggestion".tr,
                        assetName: "asset/icons/bulb.svg"),

                    buildMenuItem(
                        onClicked: () {
                          Navigator.pop(context, true);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ColorSwitcher();
                            },
                          );
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
                  Text(
                    "Made in Pakistan With",
                    overflow: TextOverflow.ellipsis,
                  ),
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
                    overflow: TextOverflow.ellipsis,
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
                      overflow: TextOverflow.ellipsis,
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

  //language setter
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
              color: theme.cardColor,
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
              "Change Language".tr,
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

updateLocale(Locale locale, BuildContext context) async {
  Get.updateLocale(locale);
  // await setLocale(locale);
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
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ),
  );
}
