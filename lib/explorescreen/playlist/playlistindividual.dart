import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/DB/Functions/recentlyplayed.dart';
import 'package:musica/DB/model/model.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/explorescreen/playlist/playlistsongdisplyscreen.dart';
import 'package:musica/provider/songmodelprovider.dart';
import 'package:musica/screens/nowplaying/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Addplaylist extends StatefulWidget {
  const Addplaylist({super.key, required this.sindex, required this.playlist});
  final int sindex;
  final Playermodel playlist;

  @override
  State<Addplaylist> createState() => _PlaylisttoaddsongState();
}

class _PlaylisttoaddsongState extends State<Addplaylist> {
  @override
  Widget build(BuildContext context) {
    late List<SongModel> songplaylist;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 37, 54),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 37, 54),
        elevation: 15,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white60,
            )),
        title: Text(
          widget.playlist.name,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(12),
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<Playermodel>('playlistdata').listenable(),
              builder: (context, Box<Playermodel> song, Widget? child) {
                songplaylist =
                    listplaylist(song.values.toList()[widget.sindex].songid);
                return songplaylist.isEmpty
                    ? const Center(
                        child: Text(
                        'Add Songs',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white60),
                      ))
                    : ListView.builder(
                        itemCount: songplaylist.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: QueryArtworkWidget(
                              type: ArtworkType.AUDIO,
                              id: songplaylist[index].id,
                              artworkHeight: 60,
                              artworkWidth: 60,
                              nullArtworkWidget: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: const Icon(
                                    Icons.music_note,
                                    color: Colors.white60,
                                  )),
                              artworkBorder: BorderRadius.circular(10),
                              artworkFit: BoxFit.cover,
                            ),
                            title: Text(songplaylist[index].title,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white70)),
                            subtitle: Text(
                              songplaylist[index].artist!,
                              style: const TextStyle(color: Colors.white70),
                              maxLines: 1,
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  widget.playlist
                                      .deletedata(songplaylist[index].id);
                                },
                                icon: const Icon(Icons.delete_outline,
                                    color: Color.fromARGB(255, 224, 86, 76))),
                            onTap: () {
                              Recentcontroller.addrecentlyplayed(
                                  songplaylist[index].id);
                              Getallsongs.audioPlayer.setAudioSource(
                                  Getallsongs.createsongslist(songplaylist));
                              context
                                  .read<Songmodelprovider>()
                                  .setid(songplaylist[index].id);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Nowplaying(
                                    songModel: songplaylist,
                                    count: songplaylist.length,
                                  );
                                },
                              ));
                            },
                          ),
                        ),
                      );
              },
            ),
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Playlistsongdisplayscreen(
                        playlist: widget.playlist,
                      )));
        },
        label: const Text('Add Songs'),
      ),
    );
  }

  List<SongModel> listplaylist(List<int> data) {
    List<SongModel> playsong = [];
    for (int i = 0; i < Getallsongs.copysong.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (Getallsongs.copysong[i].id == data[j]) {
          playsong.add(Getallsongs.copysong[i]);
        }
      }
    }

    return playsong;
  }
}
