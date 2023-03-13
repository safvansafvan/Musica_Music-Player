import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/screens/allmusic/allmusic.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Recentcontroller {
  static ValueNotifier<List<SongModel>> recenlylistnotifier = ValueNotifier([]);
  static List<dynamic> recentlyplayedsong = [];

  static Future<void> addrecentlyplayed(item) async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    recentdatabase.add(item);
    getallrecently();
     // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    recenlylistnotifier.notifyListeners();
  }

  static Future<void> getallrecently() async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    final recentlyplayedsong = recentdatabase.values.toList();
    displaydrecent();
     // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    recenlylistnotifier.notifyListeners();
  }

  static Future<void> displaydrecent() async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    final recentitems = recentdatabase.values.toList();
    recenlylistnotifier.value.clear();
    recentlyplayedsong.clear();
    for (int i = 0; i < recentitems.length; i++) {
      for (int j = 0; j < startsong.length; j++) {
        if (recentitems[i] == startsong[j].id) {
          recenlylistnotifier.value.add(startsong[j]);
          recentlyplayedsong.add(startsong[j]);
        }
      }
    }
  }
}
