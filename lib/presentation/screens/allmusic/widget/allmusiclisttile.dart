import 'package:flutter/material.dart';
import 'package:musica/presentation/screens/widget/main_listtile.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Allmusiclisttile extends StatelessWidget {
  Allmusiclisttile({
    super.key,
    required this.songmodel,
  });
  List<SongModel> songmodel = [];

  List<SongModel> songs = [];

  @override
  Widget build(BuildContext context) {
    return MusicListTile(
        songmodel: songmodel, isRecently: false, isMosltly: false);
  }
}
