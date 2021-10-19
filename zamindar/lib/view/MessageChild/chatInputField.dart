import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ChatInputField extends StatefulWidget {
  ChatInputField({Key? key}) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  bool isTyping = false;
  TextEditingController msgController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final myheight = MediaQuery.of(context).size.height;
    final myWidth = MediaQuery.of(context).size.width;
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
}
