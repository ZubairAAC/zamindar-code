import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zamindar/model/MarketData.dart';
import 'package:zamindar/model/MarketPost.dart';
import 'package:zamindar/view/MarketChild/MarketAdView.dart';
import 'package:zamindar/view/MarketChild/PostAd.dart';
import 'package:zamindar/view_model/PostAd.dart';

class Market extends StatefulWidget {
  Market({Key? key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  int _selectedIndex = -1;
  late Future<List<Ads>> getMydata;

  @override
  void initState() {
    super.initState();
    getMydata = getADSFromApi();
  }

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Zamindar Market".tr,
                  style: TextStyle(
                      color: theme.accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(children: [
            Divider(
              color: theme.accentColor,
            ),
            Container(
              height: 85,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
              ),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      print(MarketNames[index]);
                      _onSelected(index);
                      if (index == 0) {
                        // Get.to(PostAd());
                        Get.to(() => PostAd());
                        _onSelected(index - 1);
                      } else {}
                    },
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color:
                              _selectedIndex != null && _selectedIndex == index
                                  ? theme.accentColor
                                  : theme.backgroundColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                MarketImages[index],
                                height: 20,
                                width: 20,
                                color: _selectedIndex != null &&
                                        _selectedIndex == index
                                    ? theme.cardColor
                                    : theme.accentColor,
                              ),
                              SizedBox(height: 5),
                              Text(
                                MarketNames[index].tr,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: _selectedIndex != null &&
                                            _selectedIndex == index
                                        ? theme.cardColor
                                        : null),
                                overflow: TextOverflow.ellipsis,
                              )
                            ])),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Best Today".tr,
                          style: TextStyle(
                              fontSize: 15, color: theme.accentColor)),
                    ],
                  ),
                  Divider(
                    color: theme.accentColor,
                  )
                ],
              ),
            ),
            FutureBuilder<List<Ads>>(
              future: getMydata,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: theme.cardColor,
                    highlightColor: theme.backgroundColor,
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                padding: EdgeInsets.all(20),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          height: 100,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                padding: EdgeInsets.all(20),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          height: 100,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                padding: EdgeInsets.all(20),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          height: 100,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                padding: EdgeInsets.all(20),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          height: 100,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                padding: EdgeInsets.all(20),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Container(
                    child: Text("something went wrong"),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = snapshot.data![index];
                      var first = RegExp('[a-zA-Z]');
                      var second = data.city.replaceAll(first, "");
                      final cityName = second.replaceAll(": ", "");
                      return InkWell(
                        onTap: () {
                          var myicon = findIcon(data.category);

                          Get.to(() => MarketAdView(
                                adtitle: data.title,
                                myicon: myicon,
                                addescription: data.description,
                                adcategory: data.category,
                                adcity: data.city,
                                adperson: data.person,
                                adphone: data.phone,
                                adphoto: data.photo,
                              ));
                        },
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              border: Border(
                                  bottom:
                                      BorderSide(color: theme.backgroundColor)),
                            ),
                            child: Column(children: [
                              Container(
                                height: 99,
                                child: Row(children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        border: Border.all(
                                            color: theme.backgroundColor)),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                              height: 15,
                                              width: 15,
                                              decoration: BoxDecoration(
                                                color: theme.accentColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  data.imgLength,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: theme.cardColor),
                                                ),
                                              ))
                                        ]),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 240,
                                    // color: Colors.red,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              data.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              cityName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 9),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text(
                                              "31-Dec-2021",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                              // Divider(color: theme.accentColor),
                            ])),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.accentColor,
                    ),
                  );
                }
              },
            ),
          ])),
        ));
  }
}
