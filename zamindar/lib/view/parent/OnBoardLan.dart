import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:zamindar/view/parent/colorSelection.dart';

class StartLanguageScreen extends StatefulWidget {
  StartLanguageScreen({Key? key}) : super(key: key);

  @override
  _StartLanguageScreenState createState() => _StartLanguageScreenState();
}

class _StartLanguageScreenState extends State<StartLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "asset/logo/welcome.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height / 20,
              child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,

                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Spacer(),
                      Container(
                        height: 180,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Please Select your preferred language'.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  updateLocale(Locale("en_US"), context);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ColorSelection()));
                                });

                                // Get.back();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.only(right: 5, top: 10),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Text("English"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  updateLocale(Locale("ur_PK"), context);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ColorSelection()),
                                  );
                                });

                                // Get.back();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.only(right: 5, top: 10),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Text("اردو"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }

  updateLocale(Locale locale, BuildContext context) async {
    Get.updateLocale(locale);
    // await setLocale(locale);
  }
}
