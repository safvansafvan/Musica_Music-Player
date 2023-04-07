import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/provider/mostly_p_provider/mostly_provider.dart';
import 'package:musica/presentation/screens/widget/main_listtile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Mostplayed extends StatelessWidget {
  Mostplayed({super.key});

  OnAudioQuery audioQuery = OnAudioQuery();

  List<SongModel> mostly = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MostlyPlayedProvider>(context, listen: false)
          .getmostlyplayed();
    });
    return Scaffold(
      backgroundColor: appBodyColor,
      body: FutureBuilder(
        future: Provider.of<MostlyPlayedProvider>(context, listen: false)
            .getmostlyplayed(),
        builder: (context, item) {
          return Consumer<MostlyPlayedProvider>(
            builder: (context, value, child) {
              if (value.mostlyplayedlist.isEmpty) {
                return Center(
                  child: Text(
                    'Your Mostly Played Is Empty',
                    style: textStyleFuc(
                        size: 24, clr: kbackcolor, bld: FontWeight.w500),
                  ),
                );
              } else {
                final temp = value.mostlyplayedlist.reversed.toList();
                mostly = temp.toSet().toList();
                return FutureBuilder(
                  future: audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true),
                  builder: (context, item) {
                    if (item.data == null) {
                      const Center(child: CircularProgressIndicator());
                    } else if (item.data!.isEmpty) {
                      Center(
                        child: Text(
                          'No Songs In Your Internal',
                          style: textStyleFuc(
                              size: 24, clr: kbackcolor, bld: FontWeight.w500),
                        ),
                      );
                    }
                    return MusicListTile(
                        songmodel: mostly,
                        recentlylength: mostly.length > 10 ? 10 : mostly.length,
                        isMosltly: true);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
