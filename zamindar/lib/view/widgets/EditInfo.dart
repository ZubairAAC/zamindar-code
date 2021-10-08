import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class EditInfo extends StatefulWidget {
  EditInfo({Key? key}) : super(key: key);

  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget closeButton = IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: theme.accentColor,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: SvgPicture.asset(
              "asset/icons/close.svg",
              color: theme.cardColor,
              height: 7,
              width: 7,
            ))));
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      elevation: 0.0,
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
        height: 450,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              child: Row(
                children: [
                  Spacer(),
                  closeButton,
                ],
              ),
            ),
            Container(
              height: 75,
              child: Center(
                  child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(50)),
              )),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              // color: Colors.blue,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    cursorColor: theme.accentColor,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: theme.accentColor,
                        ),
                        hintText: "Enter Your Name here".tr,
                        labelText: 'Name'.tr,
                        fillColor: theme.cardColor,
                        filled: true,
                        isDense: true,
                        labelStyle: TextStyle(color: theme.accentColor),
                        hintStyle: TextStyle(fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: theme.accentColor,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: theme.accentColor, width: 2))),
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: TextField(
                      cursorColor: theme.accentColor,
                      maxLines: null,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: theme.accentColor,
                          ),
                          hintText: "Enter Your Adress here".tr,
                          labelText: 'Adress'.tr,
                          fillColor: theme.cardColor,
                          filled: true,
                          isDense: true,
                          labelStyle: TextStyle(color: theme.accentColor),
                          hintStyle: TextStyle(fontSize: 15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: theme.accentColor,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: theme.accentColor, width: 2))),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
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
                  "update".tr,
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
      ),
    );
  }
}
