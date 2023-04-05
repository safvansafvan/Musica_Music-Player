// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:musica/screens/allmusic/allmusic.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class Mostlyplayedctl {
//   static ValueNotifier<List<SongModel>> mostlyplayednotifier =ValueNotifier([]);
//   static List<SongModel> mostlyplayed = [];

//   static Future<void> addmostlyplayed(item) async {
//     final mostlyDB = await Hive.openBox('mostlyplayeddb');
//     mostlyDB.add(item);
//     getmostlyplayed();
//     // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
//     mostlyplayednotifier.notifyListeners();
//   }

//   static Future<void> getmostlyplayed() async {
//     final mostlyDB = await Hive.openBox('mostlyplayeddb');
//     final mostlyplayed = mostlyDB.values.toList();
//     displaymostlyplayedsongs();
//      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
//     mostlyplayednotifier.notifyListeners();
//   }

//  static Future displaymostlyplayedsongs() async {
//     final mostlyDB = await Hive.openBox('mostlyplayeddb');
//     final mostlyplayeditem = mostlyDB.values.toList();
//     mostlyplayednotifier.value.clear();
//     int value = 0;
//     for (var i = 0; i < mostlyplayeditem.length; i++) {
//       for (var j = 0; j < mostlyplayeditem.length; j++) {
//         if (mostlyplayeditem[i] == mostlyplayeditem[j]) {
//           value++;
//         }
//       }
//       if (value>5) {
//         for (var m = 0; m<startsong.length ; m++) {
//           if (mostlyplayeditem[i]==startsong[m].id) {
//             mostlyplayednotifier.value.add(startsong[m]);
//             mostlyplayed.add(startsong[m]);
//           }
//         }
//         value=0;
//       }
//     }
//     return mostlyplayed;
//   }
// }
