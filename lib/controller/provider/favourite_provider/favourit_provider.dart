import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteProvider with ChangeNotifier {
  bool isinitialized = false;
  final musicDatabase = Hive.box<int>('favoritesDB');
  List<SongModel> favoitessongs = [];

  isfavo(SongModel song) {
    if (musicDatabase.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  init(List<SongModel> song) async {
    for (SongModel song in song) {
      if (isfavo(song)) {
        favoitessongs.add(song);
      }
    }
    isinitialized = true;
  }

  add(SongModel song) async {
    musicDatabase.add(song.id);
    favoitessongs.add(song);
    notifyListeners();
  }

  deletesong(int id) async {
    int delete = 0;
    if (!musicDatabase.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> map = musicDatabase.toMap();
    map.forEach((key, value) {
      if (value == id) {
        delete = key;
      }
    });
    musicDatabase.delete(delete);
    favoitessongs.removeWhere((song) => song.id == id);
    notifyListeners();
  }
}
