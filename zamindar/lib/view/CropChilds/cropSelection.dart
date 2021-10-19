import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/crops.dart';
import 'package:zamindar/view/CropChilds/addfarms.dart';

class CropSelection extends StatefulWidget {
  CropSelection({Key? key}) : super(key: key);

  @override
  _CropSelectionState createState() => _CropSelectionState();
}

class _CropSelectionState extends State<CropSelection> {
  int _selectedIndex = -1;
  List selectedList = [];
  // List<int number> _selected;
  bool _isSelected = false;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              "Add Crop".tr,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorLight),
            )
          ],
        ),
        actions: [
          _isSelected
              ? InkWell(
                  onTap: () {
                    Get.to(() => addFarms());
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        Text(
                          "Next".tr,
                          style: TextStyle(
                              fontSize: 15, color: theme.primaryColorLight),
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          "asset/icons/right-arrow.svg",
                          height: 15,
                          width: 15,
                          color: theme.accentColor,
                        )
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Container(
        color: theme.backgroundColor,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 15,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // print(index);
                _onSelected(index);

                if (selectedList.length <= 2) {
                  selectedList.add(index);
                  setState(() {
                    _isSelected = true;
                  });
                } else if (selectedList.length == 3) {
                  print("limit reached");
                }
              },
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: _selectedIndex != null &&
                                    _selectedIndex == index
                                ? theme.accentColor
                                : theme.backgroundColor,
                            width: 5)),
                    child: ClipOval(
                        child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.50), BlendMode.darken),
                      child: Image.asset(
                        CropImages[index],
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    )),
                  ),
                  Center(
                    child: Text(
                      cropNames[index].tr,
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Visibility(
                      visible: _selectedIndex != null && _selectedIndex == index
                          ? true
                          : false,
                      child: Positioned(
                          right: 20,
                          top: 20,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: theme.accentColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: theme.cardColor,
                              ),
                            ),
                          )))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
