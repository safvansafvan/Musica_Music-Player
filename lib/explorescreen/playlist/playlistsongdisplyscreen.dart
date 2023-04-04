import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionplaylist.dart';
import 'package:musica/DB/model/model.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlistsongdisplayscreen extends StatefulWidget {
  const Playlistsongdisplayscreen({
    super.key,
    required this.playlist,
  });
  final Playermodel playlist;

  @override
  State<Playlistsongdisplayscreen> createState() =>
      _PlaylistsongdisplayscreenState();
}

final audioquery = OnAudioQuery();

class _PlaylistsongdisplayscreenState extends State<Playlistsongdisplayscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 37, 54),
        appBar: AppBar(
          elevation: 15.0,
          backgroundColor: const Color.fromARGB(225, 37, 37, 54),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white60,
              )),
          title: const Text(
            'Add Song To Playlist',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: audioquery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.data == null) {
                return const CircularProgressIndicator();
              }
              if (item.data!.isEmpty) {
                return const Center(child: Text('No Songs Available'));
              }
              return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: QueryArtworkWidget(
                      id: item.data![index].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 60,
                      artworkWidth: 60,
                      nullArtworkWidget: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: const Icon(
                            Icons.music_note,
                            color: Colors.white60,
                          )),
                      artworkBorder: BorderRadius.circular(10),
                      artworkFit: BoxFit.cover,
                    ),
                    title: Text(item.data![index].displayNameWOExt,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white70)),
                    subtitle: Text(
                      item.data![index].artist!,
                      style: const TextStyle(color: Colors.white70),
                      maxLines: 1,
                    ),
                    trailing: Wrap(
                      children: [
                        !widget.playlist.isvalule(item.data![index].id)
                            ? IconButton(
                                onPressed: () {
                                  Getallsongs.copysong = item.data!;
                                  setState(() {
                                    songaddplaylist(item.data![index]);
                                    Playlistdatabase.playlistnotifier
                                        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                        .notifyListeners();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white60,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  widget.playlist
                                      .deletedata(item.data![index].id);
                                  const removesongplaylistsnake = SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(222, 38, 46, 67),
                                      duration: Duration(seconds: 1),
                                      content: Center(
                                          child: Text(
                                              'Music Removed In Playlist')));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(removesongplaylistsnake);
                                },
                                icon: const Icon(Icons.remove,
                                    color: Colors.white60))
                      ],
                    ),
                  );
                },
              );
            }));
  }

  songaddplaylist(SongModel data) {
    widget.playlist.add(data.id);
    const addsongplaylistsnake = SnackBar(
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        duration: Duration(seconds: 1),
        content: Center(child: Text('Music Added In Playlist')));
    ScaffoldMessenger.of(context).showSnackBar(addsongplaylistsnake);
  }
}
