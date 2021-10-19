import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CropManuals extends StatefulWidget {
  CropManuals({Key? key}) : super(key: key);

  @override
  _CropManualsState createState() => _CropManualsState();
}

class _CropManualsState extends State<CropManuals> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
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
              "Crop Manuals".tr,
              style: TextStyle(color: theme.primaryColorLight, fontSize: 18),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: theme.backgroundColor,
          child: Column(
            children: [
              Divider(
                color: theme.accentColor,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        Image.asset(
                          "asset/logo/cutton.png",
                          fit: BoxFit.fill,
                          // centerSlice: Rect.fromLTRB(10, 10, 10, 10),
                          width: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
