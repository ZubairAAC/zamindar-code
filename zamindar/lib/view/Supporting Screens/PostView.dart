import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class PostView extends StatefulWidget {
  PostView({Key? key}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
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
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "This is Title for the post of zamindar app specially design for the farmers of Pakistan",
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
                  "This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan This is Title for the post of zamindar app specially design for the farmers of Pakistan",
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
