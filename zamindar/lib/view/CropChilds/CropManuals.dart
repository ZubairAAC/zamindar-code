import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:zamindar/view/CropChilds/manualView.dart';

class CropManuals extends StatefulWidget {
  CropManuals({Key? key}) : super(key: key);

  @override
  _CropManualsState createState() => _CropManualsState();
}

class _CropManualsState extends State<CropManuals> {
  bool downloaded = false;
  String cropName = "Chillies.pdf";
  String filePath = '';
  var percentage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkPath();
  }

  checkPath() async {
    var dir = await getExternalStorageDirectory();
    var con = await io.File(filePath).exists();
    print(con);
  }

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
                itemCount: 2,
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
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  if (downloaded = false) {
                                    getDownloadFile();
                                  } else if (downloaded = true) {
                                    print("object");
                                    getDownloadFile();
                                  }
                                },
                                icon: Icon(
                                  downloaded
                                      ? Icons.download_done_sharp
                                      : Icons.download_sharp,
                                  color: theme.accentColor,
                                  size: 30,
                                ))),
                        IgnorePointer(
                          child: AnimatedContainer(
                            duration: Duration(seconds: 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight:
                                      Radius.circular(downloaded ? 10 : 170)),
                              child: Image.asset(
                                "asset/logo/cutton.png",
                                fit: BoxFit.fill,
                                // centerSlice: Rect.fromLTRB(10, 10, 10, 10),
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
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

  Future getDownloadFile() async {
    final ref = await FirebaseStorage.instance.ref(cropName).getDownloadURL();

    String url = ref.toString();
    var dir = await getExternalStorageDirectory();
    Dio dio = Dio();
    setState(() {
      filePath = "${dir!.path}/$cropName.pdf";
    });
    final file = io.File(filePath);

    dio.download(url, filePath, onReceiveProgress: (actual, total) {
      percentage = actual / total * 100;
      if (percentage < 100) {
        percentage = percentage / 100;
        print(percentage.floor());
        setState(() {
          downloaded = true;
        });
      } else {
        setState(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Downloaded")));
        });
        Get.to(() => CropManualView(
              title: cropName,
              filename: filePath,
            ));
      }
    });
  }
}
