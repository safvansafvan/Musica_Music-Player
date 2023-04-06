import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/controller/provider/mostly_p_provider/mostly_provider.dart';
import 'package:musica/presentation/screens/nowplaying/nowplaying.dart';
import 'package:musica/presentation/screens/widget/artwork_widget/leading_art_widget.dart';
import 'package:musica/presentation/screens/widget/more_bottom_sheet/bottom_sheet.dart';
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
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: mostly.length > 10 ? 10 : mostly.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Container(
                            height: 73,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: ListTile(
                              leading: LeadingArtWidget(
                                  songmodel: mostly, index: index),
                              title: Text(mostly[index].displayNameWOExt,
                                  maxLines: 1,
                                  style: const TextStyle(color: kbackcolor)),
                              subtitle: Text(
                                '${mostly[index].artist}',
                                style: const TextStyle(color: kbackcolor),
                                maxLines: 1,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: white70,
                                    context: context,
                                    builder: (context) {
                                      return BottomSheetWidget(
                                        songmodel: mostly[index],
                                        index: index,
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: kbackcolor,
                                ),
                              ),
                              onTap: () {
                                Getallsongs.audioPlayer.setAudioSource(
                                    Getallsongs.createsongslist(mostly));
                                Getallsongs.audioPlayer.play();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Nowplaying(
                                          songModel: Getallsongs.playsong),
                                    ));
                              },
                            ),
                          ),
                        );
                      },
                    );
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
