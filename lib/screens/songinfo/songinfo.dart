import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Songinfowidget extends StatelessWidget {
  const Songinfowidget({
    super.key,
    required this.songmodel,
  });
  final SongModel songmodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(172, 39, 33, 55),
      appBar: AppBar(
        elevation: 15,
        backgroundColor: const Color.fromARGB(111, 39, 33, 55),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white60,
            )),
        title: const Text(
          'Song Info',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            QueryArtworkWidget(
              artworkHeight: 260,
              artworkWidth: 260,
              id: songmodel.id,
              type: ArtworkType.AUDIO,
              artworkFit: BoxFit.cover,
              artworkBorder: BorderRadius.circular(30),
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
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Title:${songmodel.title}',
              style: const TextStyle(
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
              // maxLines: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Artist: ${songmodel.artist == '<unknown>' ? 'Unknown Artist' : songmodel.artist}',
              style: const TextStyle(color: Colors.white54),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            // Text(
            //   'Size:${songmodel.size.toString().split('')[0]}''.MB'.toString(),
            //   style: const TextStyle(
            //     color: Colors.white54,
            //   ),
            //   textAlign: TextAlign.center,
            //   // maxLines: 1,
            // ),
            
          ],
        ),
      ),
    );
  }
}
