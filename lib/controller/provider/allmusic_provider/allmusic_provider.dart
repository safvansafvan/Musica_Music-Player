import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllMusicProvider with ChangeNotifier {
  void requestPermission() async {
    final OnAudioQuery audioqury = OnAudioQuery();
    bool status = await audioqury.permissionsStatus();
    if (!status) {
      await audioqury.permissionsRequest();
    }
    Permission.storage.request();
    notifyListeners();
  }
}
