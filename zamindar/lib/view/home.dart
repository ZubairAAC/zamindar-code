import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:zamindar/model/homePageData.dart';
import 'package:zamindar/view/Supporting%20Screens/PostView.dart';
import 'package:zamindar/view/Supporting%20Screens/askQuestion.dart';
import 'package:zamindar/view/Supporting%20Screens/notification.dart';
import 'package:zamindar/view/widgets/drawer.dart';

class mainHome extends StatefulWidget {
  mainHome({Key? key}) : super(key: key);

  @override
  _mainHomeState createState() => _mainHomeState();
}

class _mainHomeState extends State<mainHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: theme.backgroundColor,
          leading: Builder(builder: (BuildContext context) {
            return FlatButton(
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SvgPicture.asset(
                  "asset/icons/drawerIcon.svg",
                  color: theme.iconTheme.color,
                  height: 20,
                  width: 20,
                ));
          }),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: theme.iconTheme.color,
              ),
              onPressed: () {
                Get.to(() => NotificationScreen());
              },
            )
          ],
        ),
        drawer: mydrawer(),
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          Container(
            height: 85,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.18,
            ),
            decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                )),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print(HomeNames[index]);
                    Get.to(AskQuestion());
                  },
                  child: Container(
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
                              HomeImages[index],
                              height: 20,
                              width: 20,
                              color: theme.accentColor,
                            ),
                            SizedBox(height: 5),
                            Text(
                              HomeNames[index].tr,
                              style: TextStyle(fontSize: 8),
                              overflow: TextOverflow.ellipsis,
                            )
                          ])),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            // height: 50,
            padding: EdgeInsets.only(top: 2, left: 5, right: 5),
            color: theme.cardColor,
            child: TabBar(
              controller: _controller,
              // isScrollable: true,
              physics: ScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
              labelColor: theme.cardColor,
              unselectedLabelColor: theme.backgroundColor,
              // indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              tabs: [
                new Tab(
                  child: Text(
                    "Agri-Info".tr,
                    style: TextStyle(color: theme.primaryColorLight),
                  ),
                ),
                new Tab(
                    child: Text("My Village".tr,
                        style: TextStyle(color: theme.primaryColorLight))),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(controller: _controller, children: [
              Container(
                color: theme.backgroundColor,
                margin: EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        print(index);
                        Get.to(() => PostView());
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        height: 300,
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: theme.backgroundColor)),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              // color: Colors.red,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Image.asset(
                                          "asset/logo/splash.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 50,
                                    width: 265,
                                    // color: Colors.blue,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Zamindar",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "60 mints ago",
                                              style: TextStyle(fontSize: 5),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                            child: Text(
                                                "This is sample text for the post of agri info in zamindar app specialy designed for farmers community in Pakistan",
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 10),
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 238,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                      color:
                                          Color(0xFF707070).withOpacity(0.30)),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: theme.backgroundColor,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      height: 300,
                      decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color(0xFF707070).withOpacity(0.30))),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            // color: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 50,
                                  width: 265,
                                  // color: Colors.blue,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Zamindar",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "60 mints ago",
                                            style: TextStyle(fontSize: 5),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                          child: Text(
                                              "This is sample text for the post of agri info in zamindar app specialy designed for farmers community in Pakistan",
                                              maxLines: 2,
                                              style: TextStyle(fontSize: 10),
                                              overflow: TextOverflow.ellipsis)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 205,
                            decoration: BoxDecoration(
                              color: Colors.red,
                            ),
                          ),
                          Container(
                            height: 33,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                // color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                SizedBox(width: 10),
                                Container(
                                    height: 30,
                                    width: 290,
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextField(
                                      cursorColor: theme.accentColor,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        fillColor: theme.backgroundColor,
                                        suffixIcon: Icon(
                                          Icons.mic,
                                          color: theme.accentColor,
                                          size: 15,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: theme.backgroundColor,
                                        ))),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ]),
          )
        ]))));
  }
}
