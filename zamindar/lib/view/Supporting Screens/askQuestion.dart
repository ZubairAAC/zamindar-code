import 'dart:async';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view_model/soundRecording.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path/path.dart' as path;

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
  double recordingTime = 0.0;
  String postType = '';
  late FlutterSoundRecorder _myRecorder;
  final audioPlayer = AssetsAudioPlayer();
  late String filePath;
  String _recorderTxt = '00:00:00';
  bool _play = false;
  TextEditingController questionController = TextEditingController();

  //  Timer _timer;
  void _startTimer() async {
    _counter = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 1 && _endrecording == false) {
          // startRecording(pathToSaveAudio);
          record();
        }
        if (_counter <= 29 && _endrecording == false) {
          _counter++;

          print(_counter);
        } else {
          timer.cancel();
          stopRecord();
          // stopRecording();
          recordingTime = _counter / 30 * 100;

          print(
              "counter value is =>${_counter}  & counter percentage is recording time ${recordingTime}");
          // _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startIt();

    // initRecording();
  }

  void startIt() async {
    filePath = '/Download/temp.wav';
    _myRecorder = FlutterSoundRecorder();

    await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 10));
  }

  // @override
  // void dispose() {
  //   disposeRecorder();
  //   super.dispose();
  // }

  checker() {
    if (questionController.text.length == 0) {
      FormData audioData = FormData({
        'postType': 'audio',
        "question": pathToSaveAudio,
        "postingPersonName": user.name,
        "postingPersonID": "",
        "postingPersonImage": user.image,
        "timeofposting": DateTime.now(),
      });
      print(audioData.fields);
    } else {
      FormData textData = FormData({
        'postType': 'text',
        "question": questionController.text,
        "postingPersonName": user.name,
        "postingPersonID": "",
        "postingPersonImage": user.image,
        "timeofposting": DateTime.now(),
      });
      print(textData.fields);
    }
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
                "Ask Question".tr,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColorLight),
              )
            ],
          ),
          actions: [
            user.userlogin
                ? InkWell(
                    onTap: () {
                      checker();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Text(
                            "Post",
                            style: TextStyle(
                                fontSize: 15, color: theme.primaryColorLight),
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
                    ))
                : Container()
          ],
        ),
        body: user.userlogin
            ? SingleChildScrollView(
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
                    duration: Duration(milliseconds: 100),
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
                                          stopRecording();
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            _isRecording
                                                ? "asset/icons/no-stopping.svg"
                                                : "asset/icons/pen.svg",
                                            height: 20,
                                            width: 20,
                                            color: _showtextField
                                                ? theme.accentColor
                                                    .withOpacity(0.30)
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "asset/icons/microphone.svg",
                                          height: 20,
                                          width: 20,
                                          color: _endrecording
                                              ? theme.accentColor
                                                  .withOpacity(0.30)
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
                                            borderRadius:
                                                BorderRadius.circular(50)),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
                                  decoration: BoxDecoration(
                                    color: theme.backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await toggleAudio().whenComplete(
                                                () => {setState(() {})});
                                            setState(() {
                                              startPlaying();
                                              // _isPlayingAudio = true;
                                            });
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            _isPlayingAudio
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: theme.accentColor,
                                          )),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.60,
                                        child: Slider(
                                          value: recordingTime,
                                          min: 0,
                                          max: 100,
                                          divisions: 100,
                                          label:
                                              recordingTime.round().toString(),
                                          onChanged: (double e) {
                                            setState(() {
                                              recordingTime = e;
                                            });
                                          },
                                          activeColor: theme.accentColor,
                                          inactiveColor: theme.cardColor,
                                        ),
                                      ),
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
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _showtextField = false;
                                              _height = _height - 160;
                                              questionController.text = '';
                                              questionController.text.length ==
                                                  0;
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
                                    controller: questionController,
                                    // onSubmitted: (_) => node.unfocus(),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: theme.accentColor,
                                              width: 2.0),
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
                                                color: theme.accentColor,
                                                width: 2)),
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
              ))
            : Container(
                child: Center(
                  child: Text("Please Login to see".tr),
                ),
              ));
  }

  Future<void> record() async {
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder.openAudioSession();
    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription _recorderSubscription =
        _myRecorder.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

      setState(() {
        _recorderTxt = txt.substring(0, 8);
      });
    });
    _recorderSubscription.cancel();
  }

  Future stopRecord() async {
    _myRecorder.closeAudioSession();
    return await _myRecorder.stopRecorder();
  }

  Future<void> startPlaying() async {
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }

  playToggle() {
    if (_isPlayingAudio == true) {
    } else {}
  }
}



//
