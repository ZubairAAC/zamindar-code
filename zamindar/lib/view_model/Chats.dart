import 'package:cloud_firestore/cloud_firestore.dart';

class databseHelperMethods {
  createChatRoomsForChats(String chatRoomID, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomID, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessage(String chatRoomID) async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getchatRooms(String userName) async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  getlast(String doc) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(doc)
        .collection("chats")
        .snapshots()
        .last;
  }

  getuserData(String userid) async {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(userid)
        .snapshots();
  }
}
