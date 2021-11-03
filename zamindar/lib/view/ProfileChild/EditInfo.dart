import 'dart:convert';
import 'dart:io' as Io;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/onboardingLogin/SetUsername.dart';
import 'package:zamindar/view_model/sqfliteDb.dart';

class EditInfo extends StatefulWidget {
  EditInfo({Key? key}) : super(key: key);

  @override
  _EditInfoState createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  String byteArray = '';
  TextEditingController nameController = new TextEditingController();
  Future pickSingleImageFromGallery() async {
    XFile? photo =
        await ImagePicker().pickImage(source: ImageSource.gallery).whenComplete(
              () => print("done"),
            );
    if (photo == null) {
      return;
    }
    String _path = photo.path;
    final bytes = Io.File(_path).readAsBytesSync();

    setState(() {
      byteArray = base64Encode(bytes);
      user.image = byteArray;
    });
  }

  Future pickSingleImageFromCamera() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.camera)
        .whenComplete(() => print("done"));
    if (photo == null) {
      return;
    }
    String _path = photo.path;
    final bytes = Io.File(_path).readAsBytesSync();

    setState(() {
      byteArray = base64Encode(bytes);
      user.image = byteArray;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget closeButton = IconButton(
        onPressed: () {
          Get.back();
          setState(() {});
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
            Center(
              child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: theme.accentColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.accentColor,
                        radius: 90,
                        foregroundImage: user.image.isEmpty
                            ? null
                            : MemoryImage(base64Decode(user.image)),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                showImagePicker(context, byteArray);
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: theme.accentColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: theme.cardColor, width: 3)),
                              child: Icon(
                                Icons.create,
                                size: 15,
                                color: theme.cardColor,
                              ),
                            ),
                          ))
                    ],
                  )),
            ),
            SizedBox(height: 10),
            Container(
              height: 140,
              // color: Colors.blue,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController..text = user.name,
                    // initialValue: user.name.isNotEmpty ? user.name : null,
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
                    child: TextFormField(
                      initialValue: user.intialLocation.isNotEmpty
                          ? user.intialLocation
                          : null,
                      cursorColor: theme.accentColor,
                      maxLines: null,
                      onChanged: (e) {
                        e = user.intialLocation;
                      },
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
                child: InkWell(
              onTap: () async {
                await UserDB.updateUser(
                        nameController.text, user.image, user.id)
                    .whenComplete(() => {Get.back()});
              },
              child: Container(
                height: 43,
                width: 166,
                decoration: BoxDecoration(
                  color: theme.accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Update".tr,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
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
}
