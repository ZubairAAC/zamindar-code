import 'dart:io' as Io;
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamindar/model/MarketData.dart';
import 'package:zamindar/model/category.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view_model/RegisterUserApi.dart';
import 'package:zamindar/view_model/filePicker.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';

class SetProfile extends StatefulWidget {
  String phone;
  SetProfile({Key? key, required this.phone}) : super(key: key);

  @override
  _SetProfileState createState() => _SetProfileState(phone);
}

class _SetProfileState extends State<SetProfile> {
  String phone;
  _SetProfileState(this.phone);

  String byteArray = '';

  List<bool> isSelected = [false, false];
  TextEditingController nameController = new TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String userName = '';
  String gender = '';
  var _image;
  int _selectedIndex = -1;
  bool isLoading = false;
  bool isloadingforDb = false;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  namevalidator(myvalue) {
    if (myvalue.isEmpty) {
      return "Required";
    }
  }

  Future pickSingleImageFromGallery() async {
    XFile? photo =
        await ImagePicker().pickImage(source: ImageSource.gallery).whenComplete(
              () => print("done"),
            );
    if (photo == null) {
      return;
    }
    setState(() {
      // user.image = Io.File(photo.path);
      // print("this is user image ==>${user.image}");
    });
    String _path = photo.path;
    final bytes = Io.File(_path).readAsBytesSync();

    setState(() {
      byteArray = base64Encode(bytes);
      user.image = byteArray;
      _image = base64Decode(user.image);
    });
    print(byteArray);
  }

  Future pickSingleImageFromCamera() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.camera)
        .whenComplete(() => print("done"));
    if (photo == null) {
      return;
    }
    setState(() {
      // user.image = Io.File(photo.path);
      // print("this is user image ==>${user.image}");
    });

    print(photo.path);
    String _path = photo.path;
    final bytes = Io.File(_path).readAsBytesSync();

    setState(() {
      byteArray = base64Encode(bytes);
      user.image = byteArray;
      _image = base64Decode(user.image);
    });
    print(byteArray);
  }

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
                "Set Profile".tr,
                style: TextStyle(
                    color: theme.accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: isLoading
            ? isloadingforDb
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: theme.accentColor,
                        ),
                        SizedBox(height: 20),
                        Text("Creating your Profile...")
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: theme.accentColor,
                        ),
                        SizedBox(height: 20),
                        Text("Signing in...")
                      ],
                    ),
                  )
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(20),
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
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: theme.accentColor,
                                        radius: 175,
                                        foregroundImage: user.image != null
                                            ? MemoryImage(_image)
                                            : null,
                                        // foregroundImage: FileImage(image!),
                                        child: Icon(
                                          Icons.person,
                                          color: theme.cardColor,
                                          size: 120,
                                        ),
                                      ),
                                      Positioned(
                                          right: 10,
                                          bottom: 10,
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() {
                                                showImagePicker(
                                                    context, byteArray);
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: theme.accentColor,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: theme.cardColor,
                                                      width: 3)),
                                              child: Icon(
                                                Icons.create,
                                                size: 15,
                                                color: theme.cardColor,
                                              ),
                                            ),
                                          ))
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Form(
                                  key: formkey,
                                  autovalidate: true,
                                  child: TextFormField(
                                    controller: nameController,
                                    autovalidate: true,
                                    validator: (valuess) {
                                      namevalidator(valuess);
                                    },
                                    maxLength: 25,
                                    cursorColor: theme.accentColor,
                                    onChanged: (selected) {
                                      setState(() {
                                        userName = selected;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintText: "Enter Your Name here".tr,
                                        labelText: 'Name'.tr,
                                        fillColor: theme.cardColor,
                                        filled: true,
                                        isDense: true,
                                        labelStyle:
                                            TextStyle(color: theme.accentColor),
                                        hintStyle: TextStyle(fontSize: 15),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: theme.accentColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: theme.accentColor,
                                                width: 2))),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 125,
                                  decoration: BoxDecoration(
                                      color: theme.cardColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: theme.accentColor, width: 2)),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "What is your Gender?".tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: theme.accentColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Container(
                                          height: 70,
                                          // color: Colors.red,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Center(
                                            child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                              ),
                                              itemCount: 2,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        print(user.image);
                                                        _onSelected(index);
                                                        String selected =
                                                            usergender[index];
                                                        gender = selected;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 70,
                                                      width: 150,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2),
                                                      decoration: BoxDecoration(
                                                          color: _selectedIndex !=
                                                                      null &&
                                                                  _selectedIndex ==
                                                                      index
                                                              ? theme
                                                                  .accentColor
                                                              : theme
                                                                  .backgroundColor,
                                                          border: Border.all(
                                                              color: theme
                                                                  .accentColor,
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                          child: Text(
                                                        usergender[index].tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: _selectedIndex !=
                                                                        null &&
                                                                    _selectedIndex ==
                                                                        index
                                                                ? theme
                                                                    .cardColor
                                                                : null),
                                                      )),
                                                    ));
                                              },
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09),
                        CupertinoButton(
                          onPressed: () async {
                            try {
                              if (formkey.currentState!.validate()) {
                                if (userName.isNotEmpty) {
                                  if (user.image.isNotEmpty) {
                                    if (gender.isNotEmpty) {
                                      print("proceed");
                                      setState(() {
                                        user.name = userName;
                                        user.gender = gender;
                                        user.phone = phone;
                                        print("All Okay Ready to hit API");
                                      });
                                      setState(() {
                                        isLoading = true;
                                      });
                                      bool res = false;
                                      res = await registerUser();
                                      print("API RESPONSE IS ==>$res");

                                      final int number1 = Random().nextInt(99);
                                      final int number2 = Random().nextInt(99);
                                      String appname = 'Zamindar';
                                      final String finalId =
                                          number1.toString() +
                                              appname +
                                              number2.toString();

                                      bool resDb = false;
                                      resDb = await createNewUserInDB(
                                          user.name,
                                          user.phone,
                                          user.image,
                                          user.gender,
                                          finalId);

                                      print(
                                          "USER DB SETTING RESPONSE IS ===> $resDb");

                                      if (res == true) {
                                        setState(() {
                                          isLoading = false;
                                          isloadingforDb = true;
                                        });
                                        if (resDb == true) {
                                          setState(() {
                                            isloadingforDb = false;
                                            setIsLoginFlag();
                                            Get.offAll(() => HomeScreen());
                                          });
                                        }
                                      } else if (res == false ||
                                          resDb == false) {
                                        isLoading = false;
                                        print("Something went wrong");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Some Error Occured. Try Again Later')));
                                      }
                                      // }
                                    } else {
                                      showAlertDialog(context);
                                    }
                                  } else {
                                    showAlertDialog(context);
                                  }
                                } else {
                                  showAlertDialog(context);
                                }
                              }
                            } catch (e) {}
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
                ),
              ));
  }

  showImagePicker(BuildContext context, String _path) {
    final theme = Theme.of(context);
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        elevation: 0.0,
        builder: (Builder) => Container(
              height: 150,
              width: 400,
              child: Card(
                color: theme.backgroundColor,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            pickSingleImageFromGallery().whenComplete(() => {
                                  print(byteArray),
                                });
                            Get.back();
                          },
                          child: Container(
                            height: 110,
                            width: 125,
                            // color: Colors.red,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Icon(
                                      Icons.photo,
                                      color: theme.cardColor,
                                      size: 30,
                                    ),
                                    backgroundColor: theme.accentColor,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Photo Library'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            pickSingleImageFromCamera().whenComplete(() => {
                                  print(byteArray),
                                });
                            Get.back();
                          },
                          child: Container(
                            height: 110,
                            width: 125,
                            // color: Colors.red,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: theme.cardColor,
                                      size: 30,
                                    ),
                                    backgroundColor: theme.accentColor,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Camera'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  showAlertDialog(BuildContext context) {
    final theme = Theme.of(context);
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK".tr,
        style: TextStyle(color: theme.accentColor),
      ),
      onPressed: () {
        Get.back();
      },
    );
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

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: theme.backgroundColor,
      elevation: 0.0,
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
        margin: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        height: 150,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 35,
            child: Row(
              children: [
                Spacer(),
                closeButton,
              ],
            ),
          ),
          Text(
            "Information Missing".tr,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
                "Please provide all information Name, Photo, Gender etc".tr),
          )
        ]),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
