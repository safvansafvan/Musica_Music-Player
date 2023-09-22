import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/model/model/model.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/controller/provider/provider_nowp_image/songmodelprovider.dart';
import 'package:musica/controller/provider/recently__provider/recently_provider.dart';
import 'package:musica/presentation/screens/explorescreen/playlist/widget/songadd_toplaylist.dart';
import 'package:musica/presentation/screens/nowplaying/nowplaying.dart';
import 'package:musica/presentation/widget/appbar/appbar.dart';
import 'package:musica/presentation/widget/not_found_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongListScreen extends StatelessWidget {
  const SongListScreen(
      {super.key, required this.sindex, required this.playlist});
  final int sindex;
  final Playermodel playlist;

  @override
  Widget build(BuildContext context) {
    late List<SongModel> songplaylist;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: playlist.name,
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(12),
                child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Playermodel>('playlistdata').listenable(),
                  builder: (context, Box<Playermodel> song, Widget? child) {
                    songplaylist =
                        listplaylist(song.values.toList()[sindex].songid);
                    return songplaylist.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              NotFoundWidget(isMusicEmptyWid: true),
                              const Text(
                                'Add Songs',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: songplaylist.length,
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
                                    type: ArtworkType.AUDIO,
                                    id: songplaylist[index].id,
                                    artworkHeight: 60,
                                    artworkWidth: 60,
                                    nullArtworkWidget: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Icon(
                                        Icons.music_note,
                                        color: kbackcolor,
                                      ),
                                    ),
                                    artworkBorder: BorderRadius.circular(10),
                                    artworkFit: BoxFit.cover,
                                  ),
                                  title: Text(songplaylist[index].title,
                                      maxLines: 1,
                                      style:
                                          const TextStyle(color: kbackcolor)),
                                  subtitle: Text(
                                    songplaylist[index].artist!,
                                    style: const TextStyle(color: kbackcolor),
                                    maxLines: 1,
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        playlist
                                            .deletedata(songplaylist[index].id);
                                      },
                                      icon: const Icon(Icons.delete_outline,
                                          color: Color.fromARGB(
                                              255, 224, 86, 76))),
                                  onTap: () {
                                    Provider.of<RecentlyProvider>(context,
                                            listen: false)
                                        .addrecentlyplayed(
                                            songplaylist[index].id);
                                    Getallsongs.audioPlayer.setAudioSource(
                                        Getallsongs.createsongslist(
                                            songplaylist));
                                    context
                                        .read<Songmodelprovider>()
                                        .setid(songplaylist[index].id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Nowplaying(
                                            songModel: songplaylist,
                                            count: songplaylist.length,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongAddToPlaylist(
                  playlist: playlist,
                ),
              ),
            );
          },
          label: const Text('Add Songs'),
        ),
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
