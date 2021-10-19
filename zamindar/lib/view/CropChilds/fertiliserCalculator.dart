import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nController = new TextEditingController();
  TextEditingController pController = new TextEditingController();
  TextEditingController kController = new TextEditingController();
  String size = "0.5";
  double startSize = 0.5;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
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
              "Fertiliser Calculator".tr,
              style: TextStyle(color: theme.primaryColorLight, fontSize: 18),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: GestureDetector(
              onTap: () {
                print("tap");
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                color: theme.backgroundColor,
                child: Column(
                  children: [
                    Divider(
                      color: theme.accentColor,
                    ),
                    Container(
                      height: _height / 2.3,
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Form(
                        key: formkey,
                        autovalidate: true,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardAppearance: Brightness.light,
                              keyboardType: TextInputType.number,
                              controller: nController,
                              autovalidate: true,
                              validator: (valuess) {},
                              maxLength: 25,
                              cursorColor: theme.accentColor,
                              onChanged: (selected) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Enter amount of Nitrogen".tr,
                                  labelText: 'Nitrogen (N)'.tr,
                                  fillColor: theme.cardColor,
                                  filled: true,
                                  isDense: true,
                                  labelStyle:
                                      TextStyle(color: theme.accentColor),
                                  hintStyle: TextStyle(fontSize: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: theme.accentColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: theme.accentColor, width: 2))),
                            ),
                            SizedBox(height: _height * 0.05),
                            TextFormField(
                              keyboardAppearance: Brightness.light,
                              keyboardType: TextInputType.number,
                              controller: pController,
                              autovalidate: true,
                              validator: (valuess) {},
                              maxLength: 25,
                              cursorColor: theme.accentColor,
                              onChanged: (selected) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Enter amount of Phosphate".tr,
                                  labelText: 'Phosphate (P205)'.tr,
                                  fillColor: theme.cardColor,
                                  filled: true,
                                  isDense: true,
                                  labelStyle:
                                      TextStyle(color: theme.accentColor),
                                  hintStyle: TextStyle(fontSize: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: theme.accentColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: theme.accentColor, width: 2))),
                            ),
                            SizedBox(height: _height * 0.04),
                            TextFormField(
                              keyboardAppearance: Brightness.light,
                              keyboardType: TextInputType.number,
                              controller: kController,
                              autovalidate: true,
                              validator: (valuess) {},
                              maxLength: 25,
                              cursorColor: theme.accentColor,
                              onChanged: (selected) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Enter amount of Potassium".tr,
                                  labelText: 'Potassium (K20)'.tr,
                                  fillColor: theme.cardColor,
                                  filled: true,
                                  isDense: true,
                                  labelStyle:
                                      TextStyle(color: theme.accentColor),
                                  hintStyle: TextStyle(fontSize: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: theme.accentColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: theme.accentColor, width: 2))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: _height * 0.22,
                      width: _width,
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                      padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                      decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Please select Area Size in Acres".tr),
                          ),
                          SizedBox(height: _height * 0.03),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (startSize > 0.5) {
                                        startSize = startSize - 0.5;
                                        size = startSize.toString();
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: theme.accentColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: theme.cardColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  size,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _width * 0.10),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      startSize = startSize + 0.5;
                                      size = startSize.toString();
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: _width / 2,
                      decoration: BoxDecoration(
                          color: theme.accentColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Calculate".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.cardColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.10,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
