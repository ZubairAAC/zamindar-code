import 'package:firebase_auth/firebase_auth.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view_model/sqfliteDb.dart';

Future<void> fireBaseSignOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> removeUserData() async {
  await UserDB.deleteUser(user.id);
}
