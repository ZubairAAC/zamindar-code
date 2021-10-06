import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'dart:async';
import 'package:percent_indicator/linear_percent_indicator.dart';

class contactme extends StatefulWidget {
  contactme({Key? key}) : super(key: key);

  @override
  _contactmeState createState() => _contactmeState();
}

class _contactmeState extends State<contactme> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double _height = 270;
    bool _isRecording = false;
    bool _textModeIsOn = true;
    bool _endrecording = false;
    bool _showtextField = false;
    bool _isPlayingAudio = false;
    int _counter = 0;
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
          margin: EdgeInsets.only(left: 20),
          duration: Duration(milliseconds: 500),
          height: _height,
          width: MediaQuery.of(context).size.width * 0.5,
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
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextField(
                  cursorColor: theme.accentColor,
                  decoration: InputDecoration(
                      hintText: "Add Subject here",
                      labelText: 'Subject',
                      fillColor: theme.cardColor,
                      filled: true,
                      isDense: true,
                      labelStyle: TextStyle(color: theme.accentColor),
                      hintStyle: TextStyle(fontSize: 15),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.accentColor, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.accentColor, width: 2))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, top: 29),
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
                            _height = _height + 100;
                            if (_height >= 270) {
                              _height = 270;
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
                              color: theme.cardColor,
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
                                        ? theme.accentColor.withOpacity(0.30)
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
                            color: theme.cardColor,
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
                                      ? theme.accentColor.withOpacity(0.30)
                                      : theme.accentColor),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Visibility(
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
              ),
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
                                    _height = _height - 100;
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
                              hintText: 'Add Question Details',
                              labelText: 'Ask Question',
                              fillColor: theme.cardColor,
                              filled: true,
                              isDense: true,
                              labelStyle: TextStyle(color: theme.accentColor),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
