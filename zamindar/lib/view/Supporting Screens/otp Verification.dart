import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/view/Supporting%20Screens/SetUsername.dart';

class OTPScreen extends StatefulWidget {
  String phone;
  OTPScreen({Key? key, required this.phone}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState(phone);
}

class _OTPScreenState extends State<OTPScreen> {
  String phone;
  _OTPScreenState(this.phone);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          title: Row(
            children: [
              Text(
                "OTP Verification",
                style: TextStyle(
                    color: theme.accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 175,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 175,
                        width: 175,
                        decoration: BoxDecoration(
                          color: theme.accentColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.mail_outline,
                            color: theme.cardColor,
                            size: 80,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Verification ",
                      style: TextStyle(fontSize: 30, color: theme.accentColor),
                    ),
                    Text(
                      "Code",
                      style: TextStyle(
                          fontSize: 30,
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Please type the verification code",
                    style: TextStyle(fontSize: 16, color: theme.accentColor)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send to ",
                      style: TextStyle(fontSize: 16, color: theme.accentColor),
                    ),
                    Text(
                      widget.phone,
                      style: TextStyle(
                          fontSize: 16,
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: otpForm()),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                InkWell(
                  splashColor: theme.cardColor,
                  hoverColor: theme.cardColor,
                  focusColor: theme.cardColor,
                  onTap: () {
                    //  Navigator.of(context).pushReplacement(
                    //                 MaterialPageRoute(
                    //                     builder: (context) => ColorSelection());
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SetProfile(phone: phone)));
                  },
                  child: Center(
                      child: Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width * 0.70,
                    decoration: BoxDecoration(
                      color: theme.accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Continue".tr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}

class otpForm extends StatefulWidget {
  otpForm({Key? key}) : super(key: key);

  @override
  _otpFormState createState() => _otpFormState();
}

class _otpFormState extends State<otpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            style: TextStyle(fontSize: 24),
            cursorColor: theme.accentColor,
            decoration: InputDecoration(
                fillColor: theme.cardColor,
                filled: true,
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: theme.accentColor,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide:
                        BorderSide(color: theme.accentColor, width: 2))),
            onChanged: (values) {
              nextField(values, pin2FocusNode);
              print(values);
            },
          ),
        ),
        SizedBox(
          width: 60,
          height: 60,
          child: TextFormField(
            focusNode: pin2FocusNode,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            style: TextStyle(fontSize: 24),
            cursorColor: theme.accentColor,
            decoration: InputDecoration(
                fillColor: theme.cardColor,
                filled: true,
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: theme.accentColor,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide:
                        BorderSide(color: theme.accentColor, width: 2))),
            onChanged: (values) {
              print(values);
              nextField(values, pin3FocusNode);
            },
          ),
        ),
        SizedBox(
          width: 60,
          height: 60,
          child: TextFormField(
            focusNode: pin3FocusNode,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            style: TextStyle(fontSize: 24),
            cursorColor: theme.accentColor,
            decoration: InputDecoration(
                fillColor: theme.cardColor,
                filled: true,
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: theme.accentColor,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide:
                        BorderSide(color: theme.accentColor, width: 2))),
            onChanged: (values) {
              print(values);
              nextField(values, pin4FocusNode);
            },
          ),
        ),
        SizedBox(
          width: 60,
          height: 60,
          child: TextFormField(
            focusNode: pin4FocusNode,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            style: TextStyle(fontSize: 24),
            cursorColor: theme.accentColor,
            decoration: InputDecoration(
                fillColor: theme.cardColor,
                filled: true,
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: theme.accentColor,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide:
                        BorderSide(color: theme.accentColor, width: 2))),
            onChanged: (values) {
              print(values);
              pin4FocusNode!.unfocus();
            },
          ),
        ),
      ],
    ));
  }
}
