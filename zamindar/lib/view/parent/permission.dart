import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';
import 'package:zamindar/view_model/sqfliteDb.dart';
import 'package:zamindar/view_model/userLocation.dart';

class permissionScreen extends StatefulWidget {
  permissionScreen({Key? key}) : super(key: key);

  @override
  _permissionScreenState createState() => _permissionScreenState();
}

class _permissionScreenState extends State<permissionScreen> {
  bool canNav = false;
  int counter = 1;
  UserDbProvider userDb = UserDbProvider();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Column(
        children: [
          Container(
            height: _h * 0.10,
          ),
          Container(
            height: _h * 0.35,
            width: _w * 0.40,
            child: SvgPicture.asset(
              "asset/icons/permission.svg",
            ),
          ),
          Container(
            height: _h * 0.03,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "we",
                      style: TextStyle(
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: _w * 0.04),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "warmly welcome",
                      style: TextStyle(
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: _w * 0.04),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "You to",
                      style: TextStyle(
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: _w * 0.04),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Zamindar",
                      style: TextStyle(
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: _w * 0.05),
                    ),
                  ],
                ),
                SizedBox(height: _h * 0.10),
                Text("Please Allow permissions to access the app"),
                SizedBox(height: _h * 0.07),
                InkWell(
                  onTap: () async {
                    setVisitedFlag();
                    try {
                      // final locReq = await Permission.location.request();
                      // final camReq = await Permission.camera.request();
                      // print(locReq);

                      locationFinder()
                          .createState()
                          .locationService()
                          .whenComplete(() => {
                                setState(() {
                                  canNav = true;
                                  counter = counter + 1;
                                  print(counter);
                                })
                              });
                      if (counter == 2) {
                        setState(() {
                          canNav = true;
                          final String latlong = UserLocation.lat.toString() +
                              UserLocation.long.toString();
                          final memo = user(intialLocation: latlong);
                          userDb.addItem(memo);
                        });
                      }
                      if (counter > 2) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }
                      // if (canNav == true) {
                      //
                      // }
                    } catch (e) {}
                  },
                  child: Container(
                    height: _h * 0.08,
                    width: _w / 2.3,
                    decoration: BoxDecoration(
                        color: theme.accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(canNav ? "Continue" : "Allow Permission",
                          style: TextStyle(color: theme.cardColor)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
