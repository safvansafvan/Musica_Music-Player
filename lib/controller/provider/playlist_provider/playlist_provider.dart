import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:musics/controller/core/core.dart';
import 'package:musics/model/model/model.dart';
import 'package:musics/presentation/widget/snack_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

  songaddplaylist(SongModel data, playlist, ctx) {
    playlist.add(data.id);
    snackBarWidget(ctx: ctx, title: 'Music Added In Playlist', clr: blueclr);
    notifyListeners();
  }
}
