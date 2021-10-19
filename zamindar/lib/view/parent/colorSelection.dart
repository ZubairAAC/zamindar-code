import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/instance_manager.dart';
import 'package:location/location.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:zamindar/provider/theme.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/view/CropChilds/addfarms.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view_model/userLocation.dart';

class ColorSelection extends StatefulWidget {
  ColorSelection({Key? key}) : super(key: key);

  @override
  _ColorSelectionState createState() => _ColorSelectionState();
}

class _ColorSelectionState extends State<ColorSelection> {
  bool status7 = false;
  Color _textColor = Colors.black;
  Color _appBarColor = Color.fromRGBO(36, 41, 46, 1);
  Color _scaffoldBgcolor = Colors.white;

  @override
  void initState() {
    getlocations();
    super.initState();
  }

  Future<void> getlocations() async {
    locationFinder().createState().locationService();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(30),
        color: theme.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: totalHeight * 0.15,
            ),
            Text(
              "Please".tr,
              style: TextStyle(
                fontSize: totalHeight * 0.03,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Select Your".tr,
              style: TextStyle(
                fontSize: totalHeight * 0.03,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Custom Screen".tr,
              style: TextStyle(
                fontSize: totalHeight * 0.03,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Color".tr,
              style: TextStyle(
                  fontSize: totalHeight * 0.08,
                  color: theme.accentColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            FlutterSwitch(
              width: 150.0,
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
            SizedBox(height: totalHeight * 0.20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
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
                        fontSize: totalHeight * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    ));
  }
}
