import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // height: 300,
      color: theme.backgroundColor,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "asset/icons/radio-button.svg",
                      height: 20,
                      width: 20,
                      color: theme.accentColor,
                    ))
              ],
            ),
          ),
          // SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  height: 300,
                  decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: theme.backgroundColor)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        // color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.66,
                              // color: Colors.blue,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Zamindar",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "60 mints ago",
                                        style: TextStyle(fontSize: 5),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                      child: Text(
                                          "This is sample text for the post of agri info in zamindar app specialy designed for farmers community in Pakistan",
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 10),
                                          overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 238,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                                color: Color(0xFF707070).withOpacity(0.30)),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
