import 'package:firebase_auth/firebase_auth.dart';

Future<void> fireBaseSignOut() async {
  await FirebaseAuth.instance.signOut();
}
