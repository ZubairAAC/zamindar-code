import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/MarketData.dart';

class Market extends StatefulWidget {
  Market({Key? key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
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
              Text("Zamindar Market".tr,
                  style: TextStyle(
                      color: theme.accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(children: [
            Divider(
              color: theme.accentColor,
            ),
            Container(
              height: 85,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
              ),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
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
                              MarketImages[index],
                              height: 20,
                              width: 20,
                              color: theme.accentColor,
                            ),
                            SizedBox(height: 5),
                            Text(
                              MarketNames[index].tr,
                              style: TextStyle(fontSize: 8),
                              overflow: TextOverflow.ellipsis,
                            )
                          ]));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Best Today".tr,
                          style: TextStyle(
                              fontSize: 15, color: theme.accentColor)),
                    ],
                  ),
                  Divider(
                    color: theme.accentColor,
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        border: Border(
                            bottom: BorderSide(color: theme.backgroundColor)),
                      ),
                      child: Column(children: [
                        Container(
                          height: 99,
                          child: Row(children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  border:
                                      Border.all(color: theme.backgroundColor)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: theme.accentColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "3",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: theme.cardColor),
                                          ),
                                        ))
                                  ]),
                            ),
                            Container(
                              height: 100,
                              width: 250,
                              // color: Colors.red,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "This is Title Data for the post of zamindar market Place mobile app",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "ads format citi for zamindar app",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 9),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        "31-Dec-2021",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                        // Divider(color: theme.accentColor),
                      ]));
                },
              ),
            )
          ])),
        ));
  }
}
