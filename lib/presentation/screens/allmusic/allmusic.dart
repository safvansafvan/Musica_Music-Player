import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/controller/provider/allmusic_provider/allmusic_provider.dart';
import 'package:musica/controller/provider/favourite_provider/favourit_provider.dart';
import 'package:musica/presentation/screens/explorescreen/playlist/widget/songadd_toplaylist.dart';
import 'package:musica/presentation/screens/allmusic/widget/allmusiclisttile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

List<SongModel> startsong = [];

class Allsongswidget extends StatelessWidget {
  Allsongswidget({super.key});

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AllMusicProvider>(context, listen: false).requestPermission();
    });
    return FutureBuilder<List<SongModel>>(
      future: audioquery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return Center(
            child: Text(
              'No Songs In Your Internal',
              style:
                  textStyleFuc(size: 24, clr: kbackcolor, bld: FontWeight.w500),
            ),
          );
        }

        startsong = item.data!;

        // playlist
        Getallsongs.copysong = item.data!;

        if (Provider.of<FavouriteProvider>(context, listen: false)
            .isinitialized) {
          Provider.of<FavouriteProvider>(context, listen: false)
              .init(item.data!);
        }
        return Allmusiclisttile(
          songmodel: item.data!,
        );
      },
    );
  }
}
