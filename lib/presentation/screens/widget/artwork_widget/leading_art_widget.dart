import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class LeadingArtWidget extends StatelessWidget {
  LeadingArtWidget({super.key, required this.songmodel, required this.index});

  final List<SongModel> songmodel;
  int index;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: songmodel[index].id,
      type: ArtworkType.AUDIO,
      artworkHeight: 60,
      artworkWidth: 60,
      nullArtworkWidget: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: const Icon(
          Icons.music_note,
          color: kbackcolor,
        ),
      ),
      artworkBorder: BorderRadius.circular(10),
      artworkFit: BoxFit.cover,
    );
  }
}
