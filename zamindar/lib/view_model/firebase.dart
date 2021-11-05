import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/view_model/sqfliteDb.dart';

Future<void> fireBaseSignOut() async {
  await FirebaseAuth.instance.signOut();
}

removeUserData() async {
  try {
    await UserDB.deleteUser(user.id);
    return true;
  } catch (e) {
    return false;
  }
}

playUpdateMusic() {
  final assetsAudioPlayer = AssetsAudioPlayer();
  try {
    assetsAudioPlayer.open(
      Audio("asset/music/update.wav"),
    );
    // print("loaded");
  } catch (e) {
    print(e);
  }

  assetsAudioPlayer.play();
}
