import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/provider/theme.dart';

class ColorSwitcher extends StatefulWidget {
  const ColorSwitcher({Key? key}) : super(key: key);

  @override
  State<ColorSwitcher> createState() => _ColorSwitcherState();
}

class _ColorSwitcherState extends State<ColorSwitcher> {
  bool status7 = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget closeButton = IconButton(
        onPressed: () {
          setState(() {
            Get.back();
          });
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
      contentPadding: EdgeInsets.all(0),
      elevation: 0.0,
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
          height: 290,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 35,
              child: Row(
                children: [
                  Spacer(),
                  closeButton,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Please Select your preferred app appearance".tr,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.normal,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
            SizedBox(height: 20),
            FlutterSwitch(
              width: 130.0,
              height: 55.0,
              toggleSize: 45.0,
              value: status7,
              borderRadius: 30.0,
              padding: 2.0,
              activeToggleColor: theme.cardColor,
              inactiveToggleColor: theme.cardColor,
              activeSwitchBorder: Border.all(
                color: theme.cardColor,
                width: 6.0,
              ),
              inactiveSwitchBorder: Border.all(
                color: theme.cardColor,
                width: 6.0,
              ),
              activeColor: theme.cardColor,
              inactiveColor: theme.cardColor,
              activeIcon: Icon(
                Icons.nightlight_round,
                color: Colors.yellow[800],
              ),
              inactiveIcon: Icon(
                Icons.wb_sunny,
                color: Colors.green,
              ),
              onToggle: (val) {
                setState(() {
                  status7 = val;
                  print(val);
                  currentTheme.toggleTheme();
                });
              },
            ),
          ])),
    );
  }
}
