import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zamindar/view_model/RegisterUserApi.dart';

class PostView extends StatefulWidget {
  String title;
  String description;
  String img;
  PostView(
      {Key? key,
      required this.title,
      required this.description,
      required this.img})
      : super(key: key);

  @override
  _PostViewState createState() => _PostViewState(title, description, img);
}

class _PostViewState extends State<PostView> {
  String title;
  String description;
  String img;
  _PostViewState(this.title, this.description, this.img);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(bottom: 150),
          child: Column(
            children: [
              Container(
                  height: 330,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: theme.accentColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.memory(base64Decode(img))),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 20,
                    color: theme.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 50,
                  style: TextStyle(
                    fontSize: 15,
                    // color: theme.accentColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
