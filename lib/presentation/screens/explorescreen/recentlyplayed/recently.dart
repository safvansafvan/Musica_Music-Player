import 'package:flutter/material.dart';
import 'package:musics/controller/provider/recently__provider/recently_provider.dart';
import 'package:musics/presentation/widget/main_listtile.dart';
import 'package:musics/presentation/widget/not_found_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Recentwidget extends StatelessWidget {
  Recentwidget({super.key});

  final OnAudioQuery audioQuery = OnAudioQuery();

  List<SongModel> recent = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecentlyProvider>(context, listen: false).getallrecently();
    });
    return FutureBuilder(
      future: Provider.of<RecentlyProvider>(context, listen: false)
          .getallrecently(),
      builder: (context, item) {
        return Consumer<RecentlyProvider>(
          builder: (context, datas, child) {
            if (datas.recenlylist.isEmpty) {
              return NotFoundWidget(isMusicEmptyWid: false);
            } else {
              final temp = datas.recenlylist.reversed.toList();
              recent = temp.toSet().toList();
              return FutureBuilder(
                future: audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true),
                builder: (context, items) {
                  if (items.data == null) {
                    const CircularProgressIndicator();
                  } else if (items.data!.isEmpty) {
                    Column(
                      children: [
                        NotFoundWidget(isMusicEmptyWid: true),
                        const Text(
                          'No Songs In Your Internal',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    );
                  }
                  return MusicListTile(
                      songmodel: recent,
                      isRecently: true,
                      recentlylength: recent.length > 10 ? 10 : recent.length);
                },
              );
            }
          },
        );
      },
    );
  }
}
