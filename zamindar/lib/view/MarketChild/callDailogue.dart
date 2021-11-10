import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:url_launcher/url_launcher.dart';

class call extends StatefulWidget {
  String adphone;
  call({Key? key, required this.adphone}) : super(key: key);

  @override
  _callState createState() => _callState(adphone);
}

class _callState extends State<call> {
  String adphone;
  _callState(this.adphone);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sheight = MediaQuery.of(context).size.height;
    final swidth = MediaQuery.of(context).size.width;

    Widget closeButton = IconButton(
        onPressed: () {
          Get.back();
          setState(() {});
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
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              launch("tel://$adphone");
              Get.back();
            },
            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => theme.cardColor)),
            child: Text(
              "Call".tr,
              style: TextStyle(color: theme.accentColor),
            ))
      ],
      contentPadding: EdgeInsets.all(0),
      elevation: 0.0,
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
          height: sheight * 0.20,
          width: swidth * 0.90,
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: sheight * 0.045,
              child: Row(
                children: [
                  Spacer(),
                  closeButton,
                ],
              ),
            ),
            SizedBox(height: 35),
            Container(
              height: sheight * 0.08,
              margin: EdgeInsets.symmetric(horizontal: 25),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: theme.accentColor.withOpacity(0.60),
                  borderRadius: BorderRadiusDirectional.circular(10)),
              child: Row(
                children: [
                  Text(
                    adphone,
                    style: TextStyle(color: theme.cardColor),
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
