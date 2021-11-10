import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamindar/model/MarketData.dart';
import 'package:zamindar/model/MarketPost.dart';
import 'package:zamindar/model/category.dart';
import 'package:zamindar/model/city.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view/onboardingLogin/SetUsername.dart';
import 'package:zamindar/view_model/PostAd.dart';
import 'package:zamindar/view_model/filePicker.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'dart:io' as Io;

import 'package:zamindar/view_model/firebase.dart';

class PostAd extends StatefulWidget {
  PostAd({Key? key}) : super(key: key);

  @override
  _PostAdState createState() => _PostAdState();
}

class _PostAdState extends State<PostAd> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = new TextEditingController();
  TextEditingController descritionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  String byteArray = '';
  bool isVisible = true;
  bool imgSelected = true;
  List imageArray = [];
  bool isPosting = true;

  Future pickSingleImageFromGallery() async {
    XFile? photo =
        await ImagePicker().pickImage(source: ImageSource.gallery).whenComplete(
              () => print("done"),
            );
    if (photo != null) {
      imageArray.add(Io.File(photo.path));
      setState(() {
        imageArray;
        MarketPost.images = imageArray;
        print(imageArray);
      });
      return;
    }
    // setState(() {
    //   user.image = Io.File(photo.path);
    //   print("this is user image ==>${user.image}");
    // });

    // String _path = photo.path;
    // final bytes = Io.File(_path).readAsBytesSync();
    // setState(() {
    //   byteArray = base64Encode(bytes);
    // });
    // setState(() {});
  }

  Future pickSingleImageFromCamera() async {
    XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.camera)
        .whenComplete(() => print("done"));
    if (photo != null) {
      imageArray.add(Io.File(photo.path));
      setState(() {
        imageArray;
        MarketPost.images = imageArray;
        print(imageArray);
      });
      return;
    }
    // setState(() {
    //   user.image = Io.File(photo.path);
    //   print("this is user image ==>${user.image}");
    // });

    // print(photo.path);
    // String _path = photo.path;
    // final bytes = Io.File(_path).readAsBytesSync();
    // setState(() {
    //   byteArray = base64Encode(bytes);
    // });
    // setState(() {});
    // print(byteArray);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: theme.accentColor,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sell anything".tr,
              style: TextStyle(color: theme.primaryColorLight, fontSize: 18),
            )
          ],
        ),
      ),
      body: user.userlogin
          ? isPosting
              ? GestureDetector(
                  onTap: () {
                    node.unfocus();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Divider(
                          color: theme.accentColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 30, left: 20, right: 20),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Add Photos",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Stack(children: [
                                Visibility(
                                  visible: isVisible,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.183,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          "Select Photo by clicking + button",
                                          style:
                                              TextStyle(color: theme.cardColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemCount: imageArray.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return imageArray.isNotEmpty
                                        ? Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  imageArray[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                  top: 0,
                                                  right: 25,
                                                  child: CupertinoButton(
                                                    padding: EdgeInsets.zero,
                                                    minSize: 0.1,
                                                    onPressed: () {
                                                      setState(() {
                                                        imageArray
                                                            .removeAt(index);
                                                        if (imageArray.length <=
                                                            2) {
                                                          isVisible = true;
                                                        }
                                                      });
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.close,
                                                          color:
                                                              theme.cardColor,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          )
                                        : Container(
                                            margin: EdgeInsets.all(5),
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[400],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          );
                                  },
                                ),
                                Positioned(
                                  right: -3,
                                  bottom: -12,
                                  child: Visibility(
                                    visible: isVisible,
                                    child: CupertinoButton(
                                      onPressed: () {
                                        if (imageArray.length <= 2) {
                                          showImagePicker(context, byteArray);
                                          if (imageArray.length == 2) {
                                            setState(() {
                                              isVisible = false;
                                            });
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Maximum 3 pictures are allowed')));
                                          return null;
                                        }
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        decoration: BoxDecoration(
                                            color: theme.accentColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: theme.cardColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Add Title",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Form(
                                key: formkey,
                                // autovalidate: true,
                                child: Container(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        cursorColor: theme.accentColor,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Required*")
                                        ]),
                                        controller: titleController,
                                        keyboardAppearance: Brightness.light,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            node.nextFocus(),
                                        onChanged: (e) {
                                          setState(() {
                                            MarketPost.title = e;
                                            print(MarketPost.title);
                                          });
                                        },
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 2.0)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 2.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: theme.accentColor,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: theme.accentColor,
                                                  width: 2.0),
                                            ),
                                            hintText: 'Enter Title here',
                                            labelText: 'Title',
                                            fillColor: theme.cardColor,
                                            filled: true,
                                            isDense: true,
                                            labelStyle: TextStyle(
                                                color: theme.accentColor),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15)),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            "Add Price",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        cursorColor: theme.accentColor,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Required*")
                                        ]),
                                        controller: priceController,
                                        keyboardAppearance: Brightness.light,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            node.nextFocus(),
                                        onChanged: (e) {
                                          setState(() {
                                            MarketPost.price = e;
                                            print(MarketPost.price);
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 2.0)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 2.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: theme.accentColor,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: theme.accentColor,
                                                  width: 2.0),
                                            ),
                                            hintText: 'Enter Price here',
                                            labelText: 'Price',
                                            fillColor: theme.cardColor,
                                            filled: true,
                                            isDense: true,
                                            labelStyle: TextStyle(
                                                color: theme.accentColor),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15)),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            "Add Category",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        child: DropdownSearch<String>(
                                          mode: Mode.BOTTOM_SHEET,
                                          showSearchBox: true,
                                          showClearButton: true,
                                          items: categoryData,
                                          label: "Category",
                                          hint: "Please Select Category",
                                          // popupItemDisabled: (String s) =>
                                          //     s.startsWith('I'),
                                          onChanged: (e) {
                                            setState(() {
                                              MarketPost.category = e;
                                              print(MarketPost.category);
                                            });
                                          },
                                          popupBackgroundColor:
                                              theme.backgroundColor,
                                          popupBarrierDismissible: true,

                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2.0)),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            theme.accentColor,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            theme.accentColor,
                                                        width: 2.0),
                                                  ),
                                                  hintText:
                                                      'Please Select Category',
                                                  labelText: 'Category',
                                                  fillColor: theme.cardColor,
                                                  filled: true,
                                                  isDense: true,
                                                  labelStyle: TextStyle(
                                                      color:
                                                          theme.accentColor)),
                                          // selectedItem: "Brazil",
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Text(
                                            "Add Descriptions",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        cursorColor: theme.accentColor,
                                        maxLines: 8,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Required*")
                                        ]),
                                        controller: descritionController,
                                        onChanged: (vlu) {
                                          setState(() {
                                            MarketPost.description = vlu;
                                            print(MarketPost.description);
                                          });
                                        },
                                        keyboardAppearance: Brightness.light,
                                        textInputAction:
                                            TextInputAction.newline,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: theme.accentColor,
                                                  width: 2.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 2.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: theme.accentColor,
                                                    width: 2.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: theme.accentColor,
                                                    width: 2)),
                                            hintText: 'Add Descritions',
                                            labelText: 'Description',
                                            fillColor: theme.cardColor,
                                            filled: true,
                                            isDense: true,
                                            labelStyle: TextStyle(
                                                color: theme.accentColor),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15)),
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Text(
                                            "Add Address",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        child: DropdownSearch<String>(
                                          mode: Mode.BOTTOM_SHEET,
                                          showSearchBox: true,
                                          showClearButton: true,
                                          items: city,
                                          label: "City",
                                          hint: "Please Select City",
                                          // popupItemDisabled: (String s) =>
                                          //     s.startsWith('I'),
                                          onChanged: (i) {
                                            setState(() {
                                              MarketPost.city = i;
                                              print(MarketPost.city);
                                            });
                                          },
                                          popupBackgroundColor:
                                              theme.backgroundColor,
                                          popupBarrierDismissible: true,
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2.0)),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            theme.accentColor,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            theme.accentColor,
                                                        width: 2.0),
                                                  ),
                                                  hintText:
                                                      'Please Select City',
                                                  labelText: 'City',
                                                  fillColor: theme.cardColor,
                                                  filled: true,
                                                  isDense: true,
                                                  labelStyle: TextStyle(
                                                      color:
                                                          theme.accentColor)),
                                          // selectedItem: "Brazil",
                                        ),
                                      ),
                                      SizedBox(height: 40),
                                      CupertinoButton(
                                        onPressed: () async {
                                          MarketPost.imgLength =
                                              imageArray.length.toString();
                                          setState(() {
                                            isPosting = false;
                                          });

                                          if (MarketPost.title.isNotEmpty) {
                                            if (MarketPost.price.isNotEmpty) {
                                              if (MarketPost
                                                  .category!.isNotEmpty) {
                                                if (MarketPost
                                                    .description.isNotEmpty) {
                                                  if (MarketPost
                                                      .city!.isNotEmpty) {
                                                    if (MarketPost.imgLength !=
                                                        null) {
                                                      if (imageArray
                                                          .isNotEmpty) {
                                                        var res = postAd(
                                                            MarketPost.title,
                                                            MarketPost.price,
                                                            MarketPost.category,
                                                            MarketPost
                                                                .description,
                                                            MarketPost.city,
                                                            MarketPost
                                                                .imgLength,
                                                            imageArray,
                                                            user.name,
                                                            user.image,
                                                            user.phone);

                                                        print(res);
                                                        setState(() {
                                                          isPosting = true;
                                                          playUpdateMusic();
                                                          Get.back();
                                                        });
                                                      } else {
                                                        show();
                                                      }
                                                    } else {
                                                      show();
                                                    }
                                                  } else {
                                                    show();
                                                  }
                                                } else {
                                                  show();
                                                }
                                              } else {
                                                show();
                                              }
                                            } else {
                                              show();
                                            }
                                          } else {
                                            show();
                                          }
                                        },
                                        child: Container(
                                          height: 56,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70,
                                          decoration: BoxDecoration(
                                            color: theme.accentColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Post Sell".tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: theme.primaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: theme.accentColor,
                        ),
                        SizedBox(height: 20),
                        Text("Posting...")
                      ],
                    ),
                  ),
                )
          : Container(
              child: Center(
                child: Text("Please Login to see".tr),
              ),
            ),
    );
  }

  show() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 900),
        content: Text('Something is missing. Please check again')));
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
