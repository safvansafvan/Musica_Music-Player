import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionmostlyplayed.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/screens/nowplaying/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Mostplayed extends StatefulWidget {
  const Mostplayed({super.key});

  @override
  State<Mostplayed> createState() => _MostplayedState();
}

class _MostplayedState extends State<Mostplayed> {
  OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> mostly = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Mostlyplayedctl.getmostlyplayed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 33, 55),
      body: FutureBuilder(
        future: Mostlyplayedctl.getmostlyplayed(),
        builder: (context, item) {
          return ValueListenableBuilder(
            valueListenable: Mostlyplayedctl.mostlyplayednotifier,
            builder: (context, value, child) {
              if (value.isEmpty) {
                return const Center(
                  child: Text(
                    'Your Mostly Played Is Empty',
                    style: TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                );
              } else {
                final temp = value.reversed.toList();
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
                      const Center(
                        child: Text(
                          'No Songs In Your Internal',
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: mostly.length > 10 ? 10 : mostly.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: QueryArtworkWidget(
                            id: mostly[index].id,
                            type: ArtworkType.AUDIO,
                            artworkHeight: 60,
                            artworkWidth: 60,
                            nullArtworkWidget: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.music_note,
                                color: Colors.white60,
                              ),
                            ),
                            artworkBorder: BorderRadius.circular(10),
                            artworkFit: BoxFit.cover,
                          ),
                          title: Text(mostly[index].displayNameWOExt,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white70)),
                          subtitle: Text(
                            '${mostly[index].artist}',
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 1,
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
