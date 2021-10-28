import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/ProfileChild/EditInfo.dart';
import 'package:zamindar/view/ProfileChild/MyProfile/MyProfile.dart';
import 'package:zamindar/view/ProfileChild/about/about.dart';
import 'package:zamindar/view/ProfileChild/Settings/setting.dart';

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor:
            user.userlogin ? theme.focusColor : theme.backgroundColor,
        appBar: AppBar(
          backgroundColor:
              user.userlogin ? theme.focusColor : theme.backgroundColor,
          elevation: 0,
          actions: [
            user.userlogin
                ? TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditInfo();
                        },
                      );
                    },
                    child: Text(
                      "Edit".tr,
                      style: TextStyle(color: theme.shadowColor),
                    ))
                : Container()
          ],
        ),
        body: user.userlogin
            ? SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: theme.hoverColor,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              // child: CircleAvatar(
                              //   foregroundImage: MemoryImage(user.image.),
                              // ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 220,
                              height: 100,
                              // color: Colors.blue,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    user.name.isNotEmpty
                                        ? user.name
                                        : "Zamindar",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    user.phone.isNotEmpty
                                        ? user.phone
                                        : '0300123****',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Village Name",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        decoration: BoxDecoration(
                            color: theme.backgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Column(
                          children: [
                            TabBar(
                              controller: _controller,
                              // isScrollable: true,
                              physics: ScrollPhysics(),
                              dragStartBehavior: DragStartBehavior.start,
                              labelColor: theme.accentColor,
                              unselectedLabelColor: Colors.grey,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor: theme.accentColor,
                              // automaticIndicatorColorAdjustment: true,
                              indicatorWeight: 0.0,
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(width: 0.0),
                              ),
                              tabs: [
                                new Tab(
                                  child: Text(
                                    "About".tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    // style: TextStyle(color: theme.primaryColor),
                                  ),
                                ),
                                new Tab(
                                    child: Text(
                                  "My Profile".tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                  ),
                                  // style: TextStyle(color: theme.primaryColor)
                                )),
                                new Tab(
                                  child: Text(
                                    "Settings".tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    // style: TextStyle(color: theme.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _controller,
                                children: [AboutMe(), MyProfile(), MySetting()],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                child: Center(
                  child: Text("Please Login to see".tr),
                ),
              ));
  }
}
