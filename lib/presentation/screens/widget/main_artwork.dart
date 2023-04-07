import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/presentation/screens/nowplaying/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Artworkwidget extends StatelessWidget {
  const Artworkwidget({
    super.key,
    required this.widget,
    required this.currentindex,
  });
  final Nowplaying widget;
  final int currentindex;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      keepOldArtwork: true,
      id: widget.songModel[currentindex].id,
      type: ArtworkType.AUDIO,
      artworkWidth: 280,
      artworkHeight: 280,
      artworkFit: BoxFit.cover,
      artworkBorder: const BorderRadius.all(
        Radius.circular(15),
      ),
      nullArtworkWidget: Container(
        height: 280,
        width: 280,
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: const Icon(
          Icons.music_note_outlined,
          size: 120,
          color: kbackcolor,
        ),
      ),
    );
  }
}
