// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:musica/DB/model/model.dart';

// class Playlistdatabase {
//   static ValueNotifier<List<Playermodel>> playlistnotifier = ValueNotifier([]);
//   static final playlistdata = Hive.box<Playermodel>('playlistdata');

//   static Future<void> addplaylist(Playermodel value) async {
//     final playlistdata = Hive.box<Playermodel>('playlistdata');
//     await playlistdata.add(value);
//     playlistnotifier.value.add(value);
    
//   }

//   static Future<void> getallplaylist() async {
//     final playlistdata = Hive.box<Playermodel>('playlistdata');
//     playlistnotifier.value.clear();
//     playlistnotifier.value.addAll(playlistdata.values);
//      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
//     playlistnotifier.notifyListeners();
//   }

//   static Future<void> playlistdelete(int index) async {
//     final playlistdata = Hive.box<Playermodel>('playlistdata');
//     playlistdata.deleteAt(index);
//     getallplaylist();
//   }

//   static Future<void> editplaylist(Playermodel value, int index) async {
//     final playlistdata = Hive.box<Playermodel>('playlistdata');
//     playlistdata.putAt(index, value);
//     getallplaylist();
//   }
// }
