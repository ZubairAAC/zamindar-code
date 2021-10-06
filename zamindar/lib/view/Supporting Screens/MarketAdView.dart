import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MarketAdView extends StatefulWidget {
  MarketAdView({Key? key}) : super(key: key);

  @override
  _MarketAdViewState createState() => _MarketAdViewState();
}

class _MarketAdViewState extends State<MarketAdView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 350,
                padding: EdgeInsets.only(top: 20, right: 0, left: 0),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 27,
                              width: 38,
                              decoration: BoxDecoration(
                                color: theme.accentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: theme.primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                          // color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Text(
                        "This is title for the Zamindar app market place post ad specily design for farmers of pakistan",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Details",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                        height: 114,
                        // color: Colors.red,
                        child: Center(
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                height: 100,
                                width: 111,
                                decoration: BoxDecoration(
                                    color: theme.cardColor,
                                    borderRadius: BorderRadius.circular(10)),
                              );
                            },
                          ),
                        )),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Contact Person",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 105,
                      decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            height: 105,
                            width: 100,
                            decoration: BoxDecoration(
                                // color: theme.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: theme.backgroundColor)),
                          ),
                          Container(
                            width: 220,
                            // color: Colors.red,
                            margin:
                                EdgeInsets.only(left: 20, right: 5, top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Zubair Ayaz Asim Chaudhry",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  // color: Colors.blue,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: theme.backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: 15,
                                              color: theme.accentColor,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Call",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: theme.backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.email_outlined,
                                              size: 15,
                                              color: theme.accentColor,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Message",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
