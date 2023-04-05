import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/presentation/screens/allmusic/allmusic.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyPlayedProvider extends ChangeNotifier {
  List<SongModel> mostlyplayedlist = [];
  List<SongModel> mostlyplayed = [];

  Future<void> addmostlyplayed(item) async {
    final mostlyDB = await Hive.openBox('mostlyplayeddb');
    mostlyDB.add(item);
    getmostlyplayed();

    notifyListeners();
  }

  Future<void> getmostlyplayed() async {
    final mostlyDB = await Hive.openBox('mostlyplayeddb');
    final mostlyplayed = mostlyDB.values.toList();
    displaymostlyplayedsongs();
    notifyListeners();
  }

  Future displaymostlyplayedsongs() async {
    final mostlyDB = await Hive.openBox('mostlyplayeddb');
    final mostlyplayeditem = mostlyDB.values.toList();
    mostlyplayedlist.clear();
    int value = 0;
    for (var i = 0; i < mostlyplayeditem.length; i++) {
      for (var j = 0; j < mostlyplayeditem.length; j++) {
        if (mostlyplayeditem[i] == mostlyplayeditem[j]) {
          value++;
        }
      }
      if (value > 3) {
        for (var m = 0; m < startsong.length; m++) {
          if (mostlyplayeditem[i] == startsong[m].id) {
            mostlyplayedlist.add(startsong[m]);
            mostlyplayed.add(startsong[m]);
          }
        }
        value = 0;
      }
    }
    notifyListeners();
    return mostlyplayed;
  }
}
