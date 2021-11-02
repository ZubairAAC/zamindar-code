import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/onboardingLogin/otp%20Verification.dart';

class Login extends GetxController {
  loginCheckers(BuildContext context) {
    TextEditingController phoneController = new TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final _sSize = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final node = FocusScope.of(context);
    String phone = '';
    String vid = '';
    bool _val = false;
    bool isloading = false;
    FocusNode? phoneFocusNode;
    phonevalidator(myvalue) {
      String pattern =
          r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';
      RegExp regExp = new RegExp(pattern);
      if (myvalue.isEmpty) {
        return "Required";
      } else if (!regExp.hasMatch(myvalue)) {
        return 'Please enter valid mobile number';
      }
    }

    @override
    void initState() {
      phoneFocusNode = FocusNode();
    }

    @override
    void dispose() {
      super.dispose();
      phoneFocusNode!.dispose();
    }

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
        isDismissible: false,
        elevation: 0.0,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    height: _sSize * 0.35,
                    decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                "Please Enter Your Phone Number to Login".tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Form(
                          autovalidate: true,
                          key: formkey,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                              autovalidate: true,
                              controller: phoneController,
                              validator: phonevalidator,
                              focusNode: phoneFocusNode,
                              onChanged: (tf) {
                                final mine = tf.replaceFirst("0", "+92");
                                if (mine.length == 11) {
                                  // update();
                                  // phoneFocusNode!.unfocus();
                                }

                                phone = tf;
                                phone = mine;
                                print(phone);
                              },
                              keyboardAppearance: Brightness.light,
                              keyboardType: TextInputType.number,
                              cursorColor: theme.accentColor,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: theme.accentColor,
                                  ),
                                  hintText: "03001234567",
                                  labelText: 'Phone'.tr,
                                  fillColor: theme.cardColor,
                                  filled: true,
                                  isDense: true,
                                  labelStyle:
                                      TextStyle(color: theme.accentColor),
                                  hintStyle: TextStyle(fontSize: 15),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: theme.accentColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: theme.accentColor, width: 2))),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                            onTap: () async {
                              update();
                              isloading = true;
                              try {
                                if (formkey.currentState!.validate()) {
                                  print("Validated");
                                  final x = phone.substring(0, 3) +
                                      " " +
                                      phone.substring(3, phone.length);

                                  print(x);
                                  // Get.to(() =>
                                  //     OTPScreen(phone: x, verificationID: ''));

                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                      timeout: Duration(seconds: 120),
                                      phoneNumber: x,
                                      verificationCompleted:
                                          (verificationCompleted) async {
                                        // Get.to(() => OTPScreen());
                                      },
                                      verificationFailed:
                                          (verificationFaileding) async {
                                        isloading = false;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "$verificationFaileding")));
                                        print(
                                            "failed becuase of this ============> $verificationFaileding");
                                      },
                                      codeSent: (verificationid,
                                          resendingtoken) async {
                                        vid = verificationid;
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OTPScreen(
                                                          verificationID: vid,
                                                          phone: phone,
                                                        )),
                                                (Route<dynamic> route) =>
                                                    false);
                                        print(
                                            "verification id is========>$verificationid");
                                        print(
                                            "resend token is========>$resendingtoken");
                                      },
                                      codeAutoRetrievalTimeout:
                                          (codeAutoRetrievalTimeout) async {});
                                }
                              } catch (e) {
                                print("Here is an error in validating ==> $e");
                              }
                            },
                            child: Center(
                                child: Container(
                              height: 43,
                              width: 166,
                              decoration: BoxDecoration(
                                color: theme.accentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: isloading
                                  ? Center(
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                              color: theme.backgroundColor,
                                              backgroundColor:
                                                  theme.cardColor)))
                                  : Center(
                                      child: Text(
                                        "Send".tr,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: theme.primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                            )))
                      ],
                    ),
                  )),
            ));
  }
}
