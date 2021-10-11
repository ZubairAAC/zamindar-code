import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zamindar/view/Supporting%20Screens/otp%20Verification.dart';

class Login extends GetxController {
  void loginCheckers(BuildContext context) {
    TextEditingController phoneController = new TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final _sSize = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final node = FocusScope.of(context);
    String phone = '';
    bool _val = false;
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
                                "Please Enter Your Phone Number to Login",
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
                              controller: phoneController,
                              validator: phonevalidator,
                              onChanged: (tf) {
                                final mine = tf.replaceFirst("0", "92");
                                phone = tf;
                                print(mine);
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
                                  labelText: 'Phone',
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
                            onTap: () {
                              try {
                                if (formkey.currentState!.validate()) {
                                  print("Validated");

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => OTPScreen(
                                                phone: phone,
                                              )),
                                      (Route<dynamic> route) => false);
                                  // Get.to(() => OTPScreen());
                                }
                                {}
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
                            )))
                      ],
                    ),
                  )),
            ));
  }
}
