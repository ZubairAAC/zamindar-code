import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/route_manager.dart';

class rateMe extends StatefulWidget {
  rateMe({Key? key}) : super(key: key);

  @override
  _rateMeState createState() => _rateMeState();
}

class _rateMeState extends State<rateMe> {
  bool _isLiked = false;
  bool _isDisliked = false;
  double _height = 200;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget closeButton = IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: theme.accentColor,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: SvgPicture.asset(
              "asset/icons/close.svg",
              color: theme.cardColor,
              height: 7,
              width: 7,
            ))));
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        elevation: 0.0,
        backgroundColor: theme.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: AnimatedContainer(
          curve: Curves.bounceInOut,
          margin: EdgeInsets.only(left: 20),
          duration: Duration(milliseconds: 500),
          height: _height,
          decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 35,
                child: Row(
                  children: [
                    Spacer(),
                    closeButton,
                  ],
                ),
              ),
              Text(
                "Rate us",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: 75,
                        width: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  gotTapped();
                                  setState(() {
                                    _isLiked = true;
                                    _isDisliked = false;
                                    if (_height == 400) {
                                      _height = 200;
                                    }
                                    print("Liked");
                                    Timer(Duration(seconds: 1), () {
                                      Get.back();
                                      gotUpdated();
                                      Get.snackbar(
                                        "Rated successfully",
                                        "Zamindar has been rated. We Love to hear your Feedback.",
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: theme.backgroundColor,
                                      );
                                    });
                                  });
                                },
                                icon: SvgPicture.asset(
                                  "asset/icons/like.svg",
                                  color: _isLiked
                                      ? theme.accentColor
                                      : theme.accentColor.withOpacity(0.30),
                                  height: 75,
                                  width: 75,
                                )),
                            SizedBox(height: 10),
                            Text(
                              "Like it",
                              style: TextStyle(
                                fontSize: 10,
                                color: _isLiked ? theme.accentColor : null,
                              ),
                            )
                          ],
                        )),
                    Container(
                        height: 75,
                        width: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  gotTapped();
                                  setState(() {
                                    print("disliked");
                                    _isDisliked = true;
                                    _isLiked = false;
                                    _height = _height + 200;
                                    if (_height == 400) {
                                      _height = 400;
                                    }
                                  });
                                },
                                icon: SvgPicture.asset(
                                  "asset/icons/unlike.svg",
                                  color: _isDisliked
                                      ? theme.accentColor
                                      : theme.accentColor.withOpacity(0.50),
                                  height: 75,
                                  width: 75,
                                )),
                            SizedBox(height: 10),
                            Text(
                              "Not Like it",
                              style: TextStyle(
                                color: _isDisliked ? theme.accentColor : null,
                                fontSize: 10,
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Visibility(
                  visible: _isDisliked,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: theme.accentColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isDisliked = false;
                                      _height = _height - 200;
                                    });
                                  },
                                  icon: SvgPicture.asset(
                                    "asset/icons/close.svg",
                                    height: 10,
                                    width: 10,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                        Container(
                            child: TextFormField(
                          maxLines: 5,
                          cursorColor: theme.accentColor,
                          keyboardAppearance: Brightness.light,
                          textInputAction: TextInputAction.done,
                          // onSubmitted: (_) => node.unfocus(),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: theme.accentColor, width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: theme.accentColor, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: theme.accentColor, width: 2)),
                              // hintText: 'Add Question Details',
                              labelText: 'Tell us Why?',
                              fillColor: theme.cardColor,
                              filled: true,
                              isDense: true,
                              labelStyle: TextStyle(color: theme.accentColor),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        )),
                        SizedBox(height: 20),
                        Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                            color: theme.accentColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Send",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  gotTapped() {
    final assetsAudioPlayer = AssetsAudioPlayer();
    try {
      assetsAudioPlayer.open(
        Audio("asset/music/like.mp3"),
      );
      // print("loaded");
    } catch (e) {
      print(e);
    }

    assetsAudioPlayer.play();
  }

  gotUpdated() {
    final assetsAudioPlayer = AssetsAudioPlayer();
    try {
      assetsAudioPlayer.open(
        Audio("asset/music/update.wav"),
      );
      // print("loaded");
    } catch (e) {
      print(e);
    }

    assetsAudioPlayer.play();
  }
}
