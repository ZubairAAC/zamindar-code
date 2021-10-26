import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_sound/flutter_sound.dart';

final pathToSaveAudio = 'audio_example.acc';
final assetsAudioPlayer = AssetsAudioPlayer();

Future startRecording(String pathtosave) async {
  FlutterSoundRecorder? _recorder;
  await _recorder?.startRecorder(toFile: pathtosave);
  print("recording started");
}

Future stopRecording() async {
  FlutterSoundRecorder? _recorder;
  await _recorder?.stopRecorder();
  print("recording Ended");
}

Future initRecording() async {
  FlutterSoundRecorder? recorder;
  await recorder?.openAudioSession();
}

void disposeRecorder() {
  FlutterSoundRecorder? recorder;
  recorder?.closeAudioSession();
}

Future playAudio() async {
  try {
    assetsAudioPlayer.open(
      Audio.file(pathToSaveAudio),
    );
    print("loaded");
  } catch (e) {
    print(e);
  }
  assetsAudioPlayer.play();
}

Future stopAudio() async {
  assetsAudioPlayer.stop();
}

Future toggleAudio() async {
  if (assetsAudioPlayer.stop() != true) {
    await playAudio();
  } else {
    await stopAudio();
  }
}
