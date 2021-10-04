import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:zamindar/view/Supporting%20Screens/AboutView.dart';
import 'package:zamindar/view/Supporting%20Screens/Terms&PoliciesView.dart';

class MySetting extends StatefulWidget {
  MySetting({Key? key}) : super(key: key);

  @override
  _MySettingState createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 330,
            color: theme.cardColor,
            child: Column(
              children: [
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Get.to(() => AboutZamindar());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "asset/icons/info.svg",
                          color: theme.accentColor,
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "About Zamindar".tr,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "asset/icons/global.svg",
                        color: theme.accentColor,
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Change Language".tr,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => TermsView());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "asset/icons/lock.svg",
                          color: theme.accentColor,
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Terms & Policies".tr,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "asset/icons/star.svg",
                        color: theme.accentColor,
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Rate us".tr,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "asset/icons/email.svg",
                        color: theme.accentColor,
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Contact us".tr,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
              color: theme.accentColor,
              borderRadius: BorderRadius.circular(10),
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color(0XFFFBD965),
              //       Color(0XFFCF8C2A),
              //     ])
            ),
            child: Center(
              child: Text(
                "Logout".tr,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Widget buildMenuItem({
//   required String text,
//   final String assetName = 'asset/icons/',
//   required final Color iconcolor,
//   VoidCallback? onClicked,
// }) {
//   return InkWell(
//     onTap: onClicked,
//     child: Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).backgroundColor,
//       ),
//       margin: EdgeInsets.only(
//         left: 10,
//         right: 10,
//         top: 10,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             assetName,
//             color: iconcolor,
//             height: 20,
//             width: 20,
//           ),
//           SizedBox(width: 10),
//           Text(
//             text,
//           )
//         ],
//       ),
//     ),
//   );
// }
