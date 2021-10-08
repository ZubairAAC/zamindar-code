import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

void loginCheckers(BuildContext context) {
  final _sSize = MediaQuery.of(context).size.height;
  final theme = Theme.of(context);
  bool _val = false;
  Widget closeButton = IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: theme.accentColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: SvgPicture.asset(
            "asset/icons/close.svg",
            color: theme.cardColor,
            height: 15,
            width: 15,
          ))));
  showModalBottomSheet(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
            height: _sSize * 0.38,
            decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  child: Row(
                    children: [
                      Spacer(),
                      closeButton,
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  // color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        "Please Enter Your Phone Number to Login",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    cursorColor: theme.accentColor,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: theme.accentColor,
                        ),
                        hintText: "Enter Your Phone Number here",
                        labelText: 'Phone',
                        fillColor: theme.cardColor,
                        filled: true,
                        isDense: true,
                        labelStyle: TextStyle(color: theme.accentColor),
                        hintStyle: TextStyle(fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: theme.accentColor,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: theme.accentColor, width: 2))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  // color: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Checkbox(
                          activeColor: theme.accentColor,
                          value: _val,
                          onChanged: (values) {
                            values = _val;
                            print(values);
                          }),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      Text("I have read & accept all terms & conditions")
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                    child: Container(
                  height: 43,
                  width: 166,
                  decoration: BoxDecoration(
                    color: theme.accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Send",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ))
              ],
            ),
          ));
}
