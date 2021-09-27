// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zamindar/widgets/drawer.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[200],
          leading: Builder(
            builder: (BuildContext context) {
              return FlatButton(
                  // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(
                    "asset/icons/drawerIcon.svg",
                    color: Colors.green,
                    height: 20,
                    width: 20,
                  ));
            },
          ),
          //
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.green,
              ),
              onPressed: () {},
            )
          ],
        ),
        drawer: mydrawer(),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            items: [
              const BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.green,
                ),
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.green,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.store,
                  color: Colors.green,
                ),
                icon: Icon(
                  Icons.store_outlined,
                  color: Colors.green,
                ),
                title: Text('Market', style: TextStyle(color: Colors.green)),
              ),
              const BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.grass,
                  color: Colors.green,
                ),
                icon: Icon(
                  Icons.grass_outlined,
                  color: Colors.green,
                ),
                title: Text('Crops', style: TextStyle(color: Colors.green)),
              ),
              const BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.email,
                  color: Colors.green,
                ),
                icon: Icon(
                  Icons.email_outlined,
                  color: Colors.green,
                ),
                title: Text('Message', style: TextStyle(color: Colors.green)),
              ),
              const BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.account_circle,
                  color: Colors.green,
                ),
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.grey,
                ),
                title: Text('Profile', style: TextStyle(color: Colors.grey)),
              ),
            ],
            onTap: (index) {
              print(index);
            }),
        body: SingleChildScrollView(
          child: Container(
              child: Column(children: [
            Container(
              height: 85,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
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
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ));
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              // height: 50,
              padding: EdgeInsets.only(top: 2, left: 5, right: 5),
              color: Colors.white,
              child: TabBar(
                controller: _controller,
                // isScrollable: true,
                physics: ScrollPhysics(),
                dragStartBehavior: DragStartBehavior.start,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[400],
                // indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                tabs: [
                  new Tab(
                    child: Text(
                      "Agri-Info",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  new Tab(
                      child: Text("My Village",
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(controller: _controller, children: [
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.only(bottom: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                                                overflow:
                                                    TextOverflow.ellipsis)),
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
                                      child: const TextField(
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.mic,
                                            color: Colors.green,
                                            size: 15,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: Color(0xFF707070)
                                                  .withOpacity(0.30)))),
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
          ])),
        ));
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
