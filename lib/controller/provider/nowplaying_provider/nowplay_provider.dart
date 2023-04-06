import 'package:flutter/material.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';

class NowplayingScreenProvider extends ChangeNotifier {
  bool songplaying = true;

  bool isplaying() {
    notifyListeners();
    return songplaying;
  }

  void playpause() {
    songplaying = !songplaying;
  }

  void onshufflemode() {
    Getallsongs.audioPlayer.setShuffleModeEnabled(true);
  }

  void offshufflemode() {
    Getallsongs.audioPlayer.setShuffleModeEnabled(false);
  }

  void songPause() {
    Getallsongs.audioPlayer.pause();
  }

  void songPlay() {
    Getallsongs.audioPlayer.play();
  }

  chagetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Getallsongs.audioPlayer.seek(duration);
    notifyListeners();
  }
}
