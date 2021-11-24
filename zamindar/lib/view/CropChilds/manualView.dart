import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CropManualView extends StatefulWidget {
  String title;
  String filename;
  CropManualView({Key? key, required this.title, required this.filename})
      : super(key: key);

  @override
  _CropManualViewState createState() => _CropManualViewState(title, filename);
}

class _CropManualViewState extends State<CropManualView> {
  String title;
  String filename;
  _CropManualViewState(this.title, this.filename);

  @override
  Widget build(BuildContext context) {
    final file = File(filename);
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title.tr.substring(0, title.indexOf('.pdf')),
              style: TextStyle(color: theme.primaryColorLight, fontSize: 18),
            )
          ],
        ),
      ),
      backgroundColor: theme.backgroundColor,
      body: SfPdfViewer.file(file),
      // Column(
      //   children: [
      //     Divider(
      //       color: theme.accentColor,
      //     ),

      //   ],
      // ),
    );
  }
}
