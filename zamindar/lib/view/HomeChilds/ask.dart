import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/user.dart';
import 'package:http/http.dart' as http;

class Ask extends StatefulWidget {
  Ask({Key? key}) : super(key: key);

  @override
  _AskState createState() => _AskState();
}

class _AskState extends State<Ask> {
  TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: theme.accentColor)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ask Question".tr,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorLight),
            )
          ],
        ),
        actions: [
          user.userlogin
              ? questionController.text.isNotEmpty
                  ? InkWell(
                      onTap: () async {
                        var res = await postQuestion(questionController.text);
                        print(res);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            Text(
                              "Post",
                              style: TextStyle(
                                  fontSize: 15, color: theme.primaryColorLight),
                            ),
                            SizedBox(width: 5),
                            SvgPicture.asset("asset/icons/right-arrow.svg",
                                height: 15, width: 15, color: theme.accentColor)
                          ],
                        ),
                      ))
                  : Container()
              : Container()
        ],
      ),
      body: user.userlogin
          ? GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: SingleChildScrollView(
                  child: Column(children: [
                Divider(
                  color: theme.accentColor,
                ),
                Container(
                  height: h * 0.47,
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Text("Type your question".tr),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: theme.accentColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    questionController.text = '';
                                  });
                                },
                                icon: SvgPicture.asset(
                                  "asset/icons/close.svg",
                                  height: 10,
                                  width: 10,
                                  color: theme.cardColor,
                                )),
                          )
                        ],
                      ),
                      TextFormField(
                        maxLines: 10,
                        cursorColor: theme.accentColor,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.done,
                        controller: questionController,
                        // onSubmitted: (_) => node.unfocus(),
                        keyboardType: TextInputType.text,

                        decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: theme.accentColor, width: 2.0),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.accentColor, width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.accentColor, width: 2)),
                            hintText: 'Add Question Details'.tr,
                            labelText: 'Ask Question'.tr,
                            fillColor: theme.cardColor,
                            filled: true,
                            isDense: true,
                            labelStyle: TextStyle(color: theme.accentColor),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15)),
                      ),
                    ],
                  ),
                )
              ])),
            )
          : Container(
              child: Center(
                child: Text("Please Login to see".tr),
              ),
            ),
    );
  }

  Future postQuestion(String question) async {
    var sender = [{}];

    var infoToSend = {
      "description": question,
      "type": "user",
      "sender": [
        {
          'name': user.name,
          'profile': user.image,
          'id': user.id,
        }
      ],
    };

    var hitrespons;
    try {
      var res = await http.post(
          Uri.parse('https://zamindarapi.herokuapp.com/info/'),
          body: jsonEncode(infoToSend));

      if (res.statusCode == 200) {
        var body = res.body.toString();
        var newbody = jsonDecode(body);
        hitrespons = newbody['respone'];
      }
      if (hitrespons == 'Success') {
        return true;
      } else {
        return false;
      }
    } on HttpStatus catch (e) {
      print(e);
    }
  }
}
