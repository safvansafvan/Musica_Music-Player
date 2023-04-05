// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class FavoriteDB {
//   static bool isinitialized = false;
//   static final musicDatabase = Hive.box<int>('favoritesDB');
//   static ValueNotifier<List<SongModel>> favoitessongs = ValueNotifier([]);

//   static isfavo(SongModel song) {
//     if (musicDatabase.values.contains(song.id)) {
//       return true;
//     }
//     return false;
//   }

//   static init(List<SongModel> song) async {
//     for (SongModel song in song) {
//       if (isfavo(song)) {
//         favoitessongs.value.add(song);
//       }
//     }
//     isinitialized = true;
//   }

//   static add(SongModel song) async {
//     musicDatabase.add(song.id);
//     favoitessongs.value.add(song);
//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     FavoriteDB.favoitessongs.notifyListeners();
//   }

//   static deletesong(int id) async {
//     int delete = 0;
//     if (!musicDatabase.values.contains(id)) {
//       return;
//     }
//     final Map<dynamic, int> map = musicDatabase.toMap();
//     map.forEach((key, value) {
//       if (value == id) {
//         delete = key;
//       }
//     });
//     musicDatabase.delete(delete);
//     favoitessongs.value.removeWhere((song) => song.id == id);
//   }
// }
