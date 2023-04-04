import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/widget/appbar/appbar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Songinfowidget extends StatelessWidget {
  const Songinfowidget({
    super.key,
    required this.songmodel,
  });
  final SongModel songmodel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Song Info',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: const Icon(
                    Icons.music_note,
                    size: 120,
                    color: kbackcolor,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Title:${songmodel.title}',
                style: const TextStyle(
                  color: kbackcolor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Artist: ${songmodel.artist == '<unknown>' ? 'Unknown Artist' : songmodel.artist}',
                style: const TextStyle(color: kbackcolor),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
