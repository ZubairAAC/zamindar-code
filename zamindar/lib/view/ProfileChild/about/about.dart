import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AboutMe extends StatefulWidget {
  AboutMe({Key? key}) : super(key: key);

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 300,
      color: theme.backgroundColor,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 237,
            color: theme.cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.40,
                  color: theme.backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "0",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: theme.accentColor,
                            fontSize: 48,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Questions".tr,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: theme.accentColor, fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.40,
                  color: theme.backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "0",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: theme.accentColor,
                            fontSize: 48,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Answers".tr,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: theme.accentColor, fontSize: 14),
                      )
                    ],
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
