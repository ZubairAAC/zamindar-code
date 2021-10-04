import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';

class AskQuestion extends StatefulWidget {
  AskQuestion({Key? key}) : super(key: key);

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: theme.accentColor)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ask Question",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorLight),
            )
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Text(
                  "Post",
                  style:
                      TextStyle(fontSize: 15, color: theme.primaryColorLight),
                ),
                SizedBox(width: 5),
                SvgPicture.asset(
                  "asset/icons/right-arrow.svg",
                  height: 15,
                  width: 15,
                  color: theme.accentColor.withOpacity(0.60),
                )
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Divider(
            color: theme.accentColor,
          ),
          SizedBox(height: 50),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Zubair Ayaz Asim Chaudhry",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 220,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}
