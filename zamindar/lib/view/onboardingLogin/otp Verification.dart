import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/onboardingLogin/SetUsername.dart';

class OTPScreen extends StatefulWidget {
  String phone;
  String verificationID;
  OTPScreen({Key? key, required this.phone, required this.verificationID})
      : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState(phone, verificationID);
}

class _OTPScreenState extends State<OTPScreen> {
  String phone;
  String verificationID;
  _OTPScreenState(this.phone, this.verificationID);

  @override
  void initState() {
    // TODO: implement initState

    print(phone);
    print(verificationID);
  }

  String otp = '';

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
                "OTP Verification".tr,
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
                      "Verification ".tr,
                      style: TextStyle(fontSize: 30, color: theme.accentColor),
                    ),
                    Text(
                      "Code".tr,
                      style: TextStyle(
                          fontSize: 30,
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Please type the verification code".tr,
                    style: TextStyle(fontSize: 16, color: theme.accentColor)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send to ".tr,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                CupertinoButton(
                  onPressed: () {
                    // Get.to(() => SetProfile(phone: phone));
                    AuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationID, smsCode: user.otp);
                    signInWithPhoneAuthCred(phoneAuthCredential);
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

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential authCred =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        if (authCred.additionalUserInfo!.isNewUser) {
          print("its new user update Profile");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SetProfile(phone: phone)));
        } else {
          print("its an old user");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SetProfile(phone: phone)));
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
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
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  String otpCode = '';

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
          width: 50,
          height: 50,
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
              otpCode = values;
              print(otpCode);
            },
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
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
              final otp2 = values;
              otpCode = otpCode + otp2;
              print(otpCode);
              nextField(values, pin3FocusNode);
            },
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
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
              final otp3 = values;
              otpCode = otpCode + otp3;
              print(otpCode);
              nextField(values, pin4FocusNode);
            },
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
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
              final otp4 = values;
              otpCode = otpCode + otp4;
              print(otpCode);
              nextField(values, pin5FocusNode);
            },
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: TextFormField(
            focusNode: pin5FocusNode,
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
              final otp5 = values;
              otpCode = otpCode + otp5;
              print(otpCode);
              nextField(values, pin6FocusNode);
            },
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: TextFormField(
            focusNode: pin6FocusNode,
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
              final otp6 = values;
              otpCode = otpCode + otp6;
              setState(() {
                user.otp = otpCode.toString();
              });
              print("this is user otp =====> ${user.otp}");
              pin6FocusNode!.unfocus();
            },
          ),
        ),
      ],
    ));
  }
}
