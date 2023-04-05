import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/presentation/screens/allmusic/allmusic.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyProvider extends ChangeNotifier {
  List<SongModel> recenlylist = [];

  List<dynamic> recentlyplayedsong = [];

  Future<void> addrecentlyplayed(item) async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    recentdatabase.add(item);
    getallrecently();
    notifyListeners();
  }

  Future<void> getallrecently() async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    final recentlyplayedsong = recentdatabase.values.toList();
    displaydrecent();
    notifyListeners();
  }

  Future<void> displaydrecent() async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    final recentitems = recentdatabase.values.toList();
    recenlylist.clear();
    recentlyplayedsong.clear();
    for (int i = 0; i < recentitems.length; i++) {
      for (int j = 0; j < startsong.length; j++) {
        if (recentitems[i] == startsong[j].id) {
          recenlylist.add(startsong[j]);
          recentlyplayedsong.add(startsong[j]);
        }
      }
    }
    notifyListeners();
  }
}
