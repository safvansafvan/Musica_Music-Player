import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/recentlyplayed.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/screens/nowplaying/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Recentwidget extends StatefulWidget {
  const Recentwidget({super.key});

  @override
  State<Recentwidget> createState() => _RecentwidgetState();
}

class _RecentwidgetState extends State<Recentwidget> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> recent = [];
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await Recentcontroller.getallrecently();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Recentcontroller.getallrecently(),
      builder: (context, item) {
        return ValueListenableBuilder(
          valueListenable: Recentcontroller.recenlylistnotifier,
          builder: (context, value, child) {
            if (value.isEmpty) {
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
              final temp = value.reversed.toList();
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
                          leading: QueryArtworkWidget(
                            id: recent[index].id,
                            type: ArtworkType.AUDIO,
                            artworkHeight: 60,
                            artworkWidth: 60,
                            nullArtworkWidget: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: const Icon(
                                  Icons.music_note,
                                  color: kbackcolor,
                                )),
                            artworkBorder: BorderRadius.circular(10),
                            artworkFit: BoxFit.cover,
                          ),
                          title: Text(recent[index].displayNameWOExt,
                              maxLines: 1,
                              style: const TextStyle(color: kbackcolor)),
                          subtitle: Text(
                            '${recent[index].artist}',
                            style: const TextStyle(color: kbackcolor),
                            maxLines: 1,
                          ),
                          onTap: () {
                            Getallsongs.audioPlayer.setAudioSource(
                                Getallsongs.createsongslist(recent));
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
