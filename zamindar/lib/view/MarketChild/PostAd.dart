import 'dart:convert';
import 'dart:typed_data';
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
import 'package:zamindar/view/Supporting%20Screens/SetUsername.dart';
import 'package:zamindar/view_model/filePicker.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'dart:io' as Io;

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
  bool imgSelected = true;
  List imageArray = [];

  Future pickSingleImageFromGallery() async {
    XFile? photo =
        await ImagePicker().pickImage(source: ImageSource.gallery).whenComplete(
              () => print("done"),
            );
    if (photo != null) {
      imageArray.add(Io.File(photo.path));
      setState(() {
        imageArray;
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () {
                                    print(index);
                                    showImagePicker(context, byteArray);
                                  },
                                  child: imageArray.isNotEmpty
                                      ? Image.file(imageArray[index])
                                      : Container(
                                          margin: EdgeInsets.all(5),
                                          height: 100,
                                          width: 100,
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
                                              SvgPicture.asset(
                                                "asset/icons/add.svg",
                                                color: theme.cardColor,
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Add photo",
                                                style: TextStyle(
                                                    color: theme.cardColor),
                                              )
                                            ],
                                          ),
                                        ));
                            },
                          ),
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
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required*")
                                    ]),
                                    controller: titleController,
                                    keyboardAppearance: Brightness.light,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
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
                                                color: Colors.red, width: 2.0)),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.green, width: 2.0),
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
                                        labelStyle:
                                            TextStyle(color: theme.accentColor),
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15)),
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
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required*")
                                    ]),
                                    controller: priceController,
                                    keyboardAppearance: Brightness.light,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
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
                                                color: Colors.red, width: 2.0)),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.green, width: 2.0),
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
                                        labelStyle:
                                            TextStyle(color: theme.accentColor),
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15)),
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

                                      dropdownSearchDecoration: InputDecoration(
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
                                          hintText: 'Please Select Category',
                                          labelText: 'Category',
                                          fillColor: theme.cardColor,
                                          filled: true,
                                          isDense: true,
                                          labelStyle: TextStyle(
                                              color: theme.accentColor)),
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
                                    maxLines: 5,
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required*")
                                    ]),
                                    controller: descritionController,
                                    onChanged: (vlu) {
                                      setState(() {
                                        MarketPost.description = vlu;
                                        print(MarketPost.description);
                                      });
                                    },
                                    keyboardAppearance: Brightness.light,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: theme.accentColor,
                                              width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2.0)),
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
                                        labelStyle:
                                            TextStyle(color: theme.accentColor),
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15)),
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
                                      dropdownSearchDecoration: InputDecoration(
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
                                          hintText: 'Please Select City',
                                          labelText: 'City',
                                          fillColor: theme.cardColor,
                                          filled: true,
                                          isDense: true,
                                          labelStyle: TextStyle(
                                              color: theme.accentColor)),
                                      // selectedItem: "Brazil",
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  InkWell(
                                    onTap: () {
                                      print(MarketPost.title);
                                      print(MarketPost.price);
                                      print(MarketPost.category);
                                      print(MarketPost.description);
                                      print(MarketPost.city);
                                      imageArray = MarketPost.images;
                                      print(MarketPost.images);
                                    },
                                    child: Container(
                                      height: 56,
                                      width: MediaQuery.of(context).size.width *
                                          0.70,
                                      decoration: BoxDecoration(
                                        color: theme.accentColor,
                                        borderRadius: BorderRadius.circular(10),
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
          : Container(
              child: Center(
                child: Text("Please Login to see".tr),
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
