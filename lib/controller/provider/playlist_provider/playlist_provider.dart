import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:musica/DB/model/model.dart';

List<int>? songid;

class PlaylistProvider extends ChangeNotifier {
  List<Playermodel> playlist = [];
  final playlistdata = Hive.box<Playermodel>('playlistdata');

  Future<void> addplaylist(Playermodel value) async {
    final playlistdata = Hive.box<Playermodel>('playlistdata');
    await playlistdata.add(value);
    playlist.add(value);
    notifyListeners();
  }

  Future<void> getallplaylist() async {
    final playlistdata = Hive.box<Playermodel>('playlistdata');
    playlist.clear();
    playlist.addAll(playlistdata.values);
    notifyListeners();
  }

  Future<void> playlistdelete(int index) async {
    final playlistdata = Hive.box<Playermodel>('playlistdata');
    playlistdata.deleteAt(index);
    getallplaylist();
    notifyListeners();
  }

  Future<void> editplaylist(Playermodel value, int index) async {
    final playlistdata = Hive.box<Playermodel>('playlistdata');
    playlistdata.putAt(index, value);
    getallplaylist();
    notifyListeners();
  }

  // songaddplaylist(SongModel data, ctx) {
  //   playlist.add(data.id);
  //   notifyListeners();

  //   snackBarWidget(ctx: ctx, title: 'Music Added In Playlist', clr: blueclr);
  // }
}
