import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: theme.accentColor,
            ),
          ),
          title: Row(
            children: [
              Text(
                "Notification",
                style: TextStyle(
                    color: theme.accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Divider(
              color: theme.accentColor,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: theme.cardColor,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin:
                          EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 1),
                      padding: EdgeInsets.only(left: 20, right: 5),
                      height: 70,
                      color: theme.backgroundColor,
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 70,
                            width: 230,
                            // color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  "Zubair Ayaz Asim Chaudhry",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "This is the last message from me see u good bye have a nice day",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "31-12-2021",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 8),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                },
              ),
            ),
          ]),
        ));
  }
}
