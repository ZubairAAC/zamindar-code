import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/chat.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view_model/Chats.dart';

class inChat extends StatefulWidget {
  String name;
  String img;
  String charroomid;
  inChat({
    Key? key,
    required this.name,
    required this.img,
    required this.charroomid,
  }) : super(key: key);

  @override
  _inChatState createState() => _inChatState(name, img, charroomid);
}

class _inChatState extends State<inChat> {
  String name;
  String img;
  String charroomid;
  _inChatState(
    this.name,
    this.img,
    this.charroomid,
  );
  TextEditingController msgController = TextEditingController();
  @override
  databseHelperMethods databaseMethods = new databseHelperMethods();
  sendMsg() {
    Map<String, dynamic> messageMap = {
      "Message": msgController.text,
      "SendBy": user.name,
      "time": DateTime.now().microsecondsSinceEpoch
    };
    databaseMethods.addConversationMessage(widget.charroomid, messageMap);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final myheight = MediaQuery.of(context).size.height;
    final myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: appBar(theme, myWidth),
      body: Body(),
    );
  }

  Widget chatTextField() {
    final theme = Theme.of(context);
    bool isTyping = true;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.mic, color: theme.accentColor),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20 / 4),
                    Expanded(
                      child: TextField(
                        cursorColor: theme.accentColor,
                        controller: msgController,
                        decoration: InputDecoration(
                          hintText: "Type message".tr,
                          border: InputBorder.none,
                        ),
                        onChanged: (values) {
                          if (values.isNotEmpty) {
                            setState(() {
                              isTyping = true;
                            });
                          } else {
                            setState(() {
                              isTyping = false;
                            });
                          }
                        },
                      ),
                    ),
                    isTyping
                        ? Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: theme.accentColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    msgController.clear();
                                    sendMsg();
                                    setState(() {
                                      isTyping = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    size: 20,
                                    color: theme.cardColor,
                                  )),
                            ))
                        : Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  color: theme.accentColor,
                                ),
                                SizedBox(width: 20 / 4),
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: theme.accentColor,
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column Body() => Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 5),
              child: ListView.builder(
                itemCount: demeChatMessages.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Message(message: demeChatMessages[index]);
                },
              ),
            ),
          ),
          chatTextField(),
          // ChatInputField(),
        ],
      );

  AppBar appBar(ThemeData theme, double myWidth) {
    return AppBar(
      backgroundColor: theme.accentColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(
            color: theme.cardColor,
          ),
          CircleAvatar(
            backgroundImage: MemoryImage(base64Decode(img)),
          ),
          SizedBox(width: myWidth * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16, color: theme.cardColor),
              ),
            ],
          )
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       Icons.local_phone,
      //       color: theme.cardColor,
      //     ),
      //     onPressed: () {},
      //   ),
      //   SizedBox(width: myWidth * 0.05),
      // ],
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
        case ChatMessageType.video:
          return VideoMessage();
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("asset/logo/splash.png"),
            ),
            SizedBox(width: 20 / 2),
          ],
          messageContaint(message),
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .accentColor
            .withOpacity(message!.isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: TextStyle(
          color: message!.isSender ? Theme.of(context).cardColor : null,
        ),
      ),
    );
  }
}

class AudioMessage extends StatelessWidget {
  final ChatMessage? message;

  const AudioMessage({Key? key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 20 / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context)
            .accentColor
            .withOpacity(message!.isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message!.isSender
                ? Colors.white
                : Theme.of(context).accentColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message!.isSender
                        ? Colors.white
                        : Theme.of(context).accentColor.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message!.isSender
                            ? Colors.white
                            : Theme.of(context).accentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style: TextStyle(
                fontSize: 12, color: message!.isSender ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}

class VideoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("asset/logo/welcome.png"),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
