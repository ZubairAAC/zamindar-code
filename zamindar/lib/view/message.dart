import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/view/widgets/LoginChecker.dart';

class Message extends StatefulWidget {
  Message({
    Key? key,
  }) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late final Login mylogin;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final assetName = 'asset/icons/filter.svg';
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Login().loginCheckers(context);
              },
              icon: SvgPicture.asset(
                assetName,
                height: 15,
                width: 15,
                color: theme.accentColor,
              ))
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Message".tr,
                style: TextStyle(
                    color: theme.accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 5, right: 5),
          padding: EdgeInsets.only(top: 40),
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.only(top: 1, left: 2, right: 2),
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
                                  fontWeight: FontWeight.bold, fontSize: 15),
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
                      // SizedBox(width: 10),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
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
      ),
    );
  }
}
