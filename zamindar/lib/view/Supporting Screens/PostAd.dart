import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:zamindar/model/MarketData.dart';
import 'package:zamindar/model/category.dart';
import 'package:zamindar/model/city.dart';
import 'package:zamindar/view_model/filePicker.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PostAd extends StatefulWidget {
  PostAd({Key? key}) : super(key: key);

  @override
  _PostAdState createState() => _PostAdState();
}

class _PostAdState extends State<PostAd> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = new TextEditingController();
  TextEditingController descritionController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
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
              "Sell Anything",
              style: TextStyle(color: theme.primaryColorLight, fontSize: 18),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: theme.accentColor,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
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
                  InkWell(
                    onTap: () {
                      // loadAssets();
                      // selectImages();
                      // pickMultipleImages();
                    },
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "asset/icons/add.svg",
                            color: theme.cardColor,
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Add up to 3 photos",
                            style: TextStyle(color: theme.cardColor),
                          )
                        ],
                      ),
                    ),
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
                            validator: MultiValidator(
                                [RequiredValidator(errorText: "Required*")]),
                            controller: titleController,
                            keyboardAppearance: Brightness.light,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
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
                                      color: theme.accentColor, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: theme.accentColor, width: 2.0),
                                ),
                                hintText: 'Enter Title here',
                                labelText: 'Title',
                                fillColor: theme.cardColor,
                                filled: true,
                                isDense: true,
                                labelStyle: TextStyle(color: theme.accentColor),
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
                              popupItemDisabled: (String s) =>
                                  s.startsWith('I'),
                              onChanged: print,
                              popupBackgroundColor: theme.backgroundColor,
                              popupBarrierDismissible: true,

                              dropdownSearchDecoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0)),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.accentColor, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.accentColor, width: 2.0),
                                  ),
                                  hintText: 'Please Select Category',
                                  labelText: 'Category',
                                  fillColor: theme.cardColor,
                                  filled: true,
                                  isDense: true,
                                  labelStyle:
                                      TextStyle(color: theme.accentColor)),
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
                            validator: MultiValidator(
                                [RequiredValidator(errorText: "Required*")]),
                            controller: descritionController,
                            keyboardAppearance: Brightness.light,
                            textInputAction: TextInputAction.done,
                            // onSubmitted: (_) => node.unfocus(),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: theme.accentColor, width: 2.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.accentColor, width: 2.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.accentColor, width: 2)),
                                hintText: 'Add Descritions',
                                labelText: 'Description',
                                fillColor: theme.cardColor,
                                filled: true,
                                isDense: true,
                                labelStyle: TextStyle(color: theme.accentColor),
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
                              popupItemDisabled: (String s) =>
                                  s.startsWith('I'),
                              onChanged: print,
                              popupBackgroundColor: theme.backgroundColor,
                              popupBarrierDismissible: true,
                              dropdownSearchDecoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0)),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.accentColor, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.accentColor, width: 2.0),
                                  ),
                                  hintText: 'Please Select City',
                                  labelText: 'City',
                                  fillColor: theme.cardColor,
                                  filled: true,
                                  isDense: true,
                                  labelStyle:
                                      TextStyle(color: theme.accentColor)),
                              // selectedItem: "Brazil",
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 56,
                            width: MediaQuery.of(context).size.width * 0.70,
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
    );
  }
}
