import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:flutter_glow/flutter_glow.dart';

class WeatherView extends StatefulWidget {
  WeatherView({Key? key}) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHieght = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            today(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Next 7 days",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.accentColor),
              ),
            ),
            NextSevenDays(),
            // SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class today extends StatelessWidget {
  const today({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHieght = MediaQuery.of(context).size.height;
    return SafeArea(
        child: GlowContainer(
      height: screenHieght * 0.55,
      color: Colors.blue,
      spreadRadius: 1.0,
      glowColor: Colors.blue,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                // margin: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 27,
                        width: 38,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: theme.accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: theme.primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class NextSevenDays extends StatelessWidget {
  const NextSevenDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHieght = MediaQuery.of(context).size.height;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 1500, minHeight: 56.0),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 8,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GlowContainer(
            height: 100,
            margin: EdgeInsets.only(left: 20, right: 20, top: 5),
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            glowColor: theme.backgroundColor,
          );
        },
      ),
    );
  }
}
