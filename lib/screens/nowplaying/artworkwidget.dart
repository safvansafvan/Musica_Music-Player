import 'package:flutter/material.dart';
import 'package:musica/screens/nowplaying/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Artworkwidget extends StatelessWidget {
  const Artworkwidget({
    super.key, required this.widget, required this.currentindex,
  });
  final Nowplaying widget;
  final int currentindex;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      keepOldArtwork: true,
      id: widget.songModel[currentindex].id,
      type: ArtworkType.AUDIO,
      artworkWidth: 250,
      artworkHeight: 250,
      artworkFit: BoxFit.cover,
      artworkBorder: const BorderRadius.all(
        Radius.circular(30),
      ),
      nullArtworkWidget: Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(
            Icons.music_note,
            size: 120,
            color: Colors.white60,
          )),
    );
  }
}
