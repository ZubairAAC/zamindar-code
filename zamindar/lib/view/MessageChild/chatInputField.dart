import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  ChatInputField({Key? key}) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
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
                  color: theme.accentColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20 / 4),
                    Expanded(
                      child: TextField(
                        cursorColor: theme.accentColor,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
