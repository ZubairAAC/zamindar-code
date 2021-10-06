import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AskQuestion extends StatefulWidget {
  AskQuestion({Key? key}) : super(key: key);

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  double _height = 100;
  bool _isRecording = false;
  bool _textModeIsOn = true;
  bool _endrecording = false;
  int _counter = 0;
  bool _showtextField = false;
  bool _isPlayingAudio = false;
  //  Timer _timer;
  void _startTimer() {
    _counter = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter <= 29 && _endrecording == false) {
          _counter++;
          print(_counter);
        } else {
          timer.cancel();
          // _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
                "Ask Question",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColorLight),
              )
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(
                    "Post",
                    style:
                        TextStyle(fontSize: 15, color: theme.primaryColorLight),
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    "asset/icons/right-arrow.svg",
                    height: 15,
                    width: 15,
                    color: _endrecording
                        ? theme.accentColor
                        : theme.accentColor.withOpacity(0.30),
                  )
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Divider(
              color: theme.accentColor,
            ),
            SizedBox(height: 50),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Zubair Ayaz Asim Chaudhry",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: _height,
              // height: 270,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Visibility(
                    // visible: _showtextField,
                    child: Container(
                      height: 70,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: _textModeIsOn,
                            // visible: _picSelectionHidden,
                            child: InkWell(
                              onTap: () {
                                print("Type");
                                setState(() {
                                  _height = _height + 160;
                                  if (_height >= 260) {
                                    _height = 260;
                                  }
                                  if (_isRecording == false) {
                                    _showtextField = true;
                                  } else {
                                    _endrecording = true;
                                    _isRecording = false;
                                  }

                                  // _picSelectionHidden = true;
                                });
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: theme.backgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      _isRecording
                                          ? "asset/icons/no-stopping.svg"
                                          : "asset/icons/pen.svg",
                                      height: 20,
                                      width: 20,
                                      color: _showtextField
                                          ? theme.accentColor.withOpacity(0.30)
                                          : theme.accentColor,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      _isRecording ? "Stop" : "Type",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: _showtextField
                                              ? theme.accentColor
                                                  .withOpacity(0.30)
                                              : theme.accentColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              print("Record Voice");
                              setState(() {
                                _isRecording = true;
                                _startTimer();
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: theme.backgroundColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "asset/icons/microphone.svg",
                                    height: 20,
                                    width: 20,
                                    color: _endrecording
                                        ? theme.accentColor.withOpacity(0.30)
                                        : theme.accentColor,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    _isRecording
                                        ? "Recording \n0.$_counter seconds"
                                        : "Record",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: _endrecording
                                            ? theme.primaryColorLight
                                                .withOpacity(0.30)
                                            : theme.primaryColorLight),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _endrecording,
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.red,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
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
                                          _height = _height - 160;
                                          _endrecording = false;
                                          // _showtextField = false;
                                          // _height = _height - 160;
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
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 70,
                            decoration: BoxDecoration(
                              color: theme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPlayingAudio = true;
                                      });
                                    },
                                    icon: Icon(
                                      _isPlayingAudio
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: theme.accentColor,
                                    )),
                                LinearPercentIndicator(
                                  animation: true,
                                  width: 250,
                                  backgroundColor: theme.cardColor,
                                  animationDuration: 2000,
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  percent: 0.7,
                                  progressColor: theme.accentColor,
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  Visibility(
                      visible: _showtextField,
                      child: Column(
                        children: [
                          SizedBox(height: 5),
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
                                        _showtextField = false;
                                        _height = _height - 160;
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
                                          color: theme.accentColor,
                                          width: 2.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: theme.accentColor, width: 2)),
                                  hintText: 'Add Question Details',
                                  labelText: 'Ask Question',
                                  fillColor: theme.cardColor,
                                  filled: true,
                                  isDense: true,
                                  labelStyle:
                                      TextStyle(color: theme.accentColor),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15)),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            //here is
          ],
        )));
  }
}



//
