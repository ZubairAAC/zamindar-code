import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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

  @override
  databseHelperMethods databaseMethods = new databseHelperMethods();
  Stream chatMessageStream = const Stream.empty();
  TextEditingController msgController = new TextEditingController();
  bool isTyping = false;

  @override
  void initState() {
    databaseMethods.getConversationMessage(charroomid).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final myheight = MediaQuery.of(context).size.height;
    final myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: appBar(theme, myWidth),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 5),
              child: StreamBuilder(
                  stream: chatMessageStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).accentColor,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Something went wrong"),
                          );
                        }
                        if (snapshot.data == null) {
                          return Container();
                        }
                        return messageTile(
                            message: snapshot.data.docs[index]['Message'],
                            isSendByMe: snapshot.data.docs[index]['SendBy'] ==
                                user.name);
                        // return Message(message: demeChatMessages[index]);
                      },
                    );
                  }),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
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
                                if (values.length > 0) {
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
                                          sendMsg(msgController.text);
                                          msgController.clear();
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
                              : Row(
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
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          // chatTextField(),
          // ChatInputField(),
        ],
      ),
    );
  }

  sendMsg(String mytext) {
    Map<String, dynamic> messageMap = {
      "Message": mytext,
      "SendBy": user.name,
      "time": DateTime.now().microsecondsSinceEpoch
    };
    databaseMethods.addConversationMessage(charroomid, messageMap);
  }

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

// ignore: camel_case_types
class messageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  const messageTile({Key? key, required this.message, required this.isSendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
            top: 3, left: isSendByMe ? 70 : 0, right: isSendByMe ? 0 : 70),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color:
              Theme.of(context).accentColor.withOpacity(isSendByMe ? 0.38 : 1),
          borderRadius: isSendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 15,
            color: isSendByMe ? Colors.black : Colors.black,
          ),
        ),
      ),
    );
  }
}
