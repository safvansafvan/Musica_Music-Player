import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/controller/provider/recently__provider/recently_provider.dart';
import 'package:musica/presentation/screens/nowplaying/nowplaying.dart';
import 'package:musica/presentation/screens/widget/artwork_widget/leading_art_widget.dart';
import 'package:musica/presentation/screens/widget/more_bottom_sheet/bottom_sheet.dart';
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
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 150.0),
                  child: Text(
                    "Your Recent Is Empty",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kbackcolor),
                  ),
                ),
              );
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
                    const Center(
                      child: Center(
                          child: Text(
                        'No songs in your internal',
                        style: TextStyle(color: Colors.black),
                      )),
                    );
                  }
                  return ListView.builder(
                    controller: ScrollController(keepScrollOffset: true),
                    shrinkWrap: true,
                    itemCount: recent.length > 10 ? 10 : recent.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        height: 73,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: ListTile(
                          leading:
                              LeadingArtWidget(songmodel: recent, index: index),
                          title: Text(recent[index].displayNameWOExt,
                              maxLines: 1,
                              style: const TextStyle(color: kbackcolor)),
                          subtitle: Text(
                            '${recent[index].artist}',
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
                                    songmodel: recent[index],
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
                                Getallsongs.createsongslist(recent));
                            Getallsongs.audioPlayer.play();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Nowplaying(songModel: Getallsongs.playsong),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
