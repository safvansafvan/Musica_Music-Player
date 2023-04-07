import 'package:flutter/material.dart';
import 'package:musica/DB/model/model.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:musica/presentation/screens/widget/appbar/appbar.dart';
import 'package:musica/presentation/screens/widget/main_listtile.dart';
import 'package:musica/presentation/screens/widget/snack_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongAddToPlaylist extends StatelessWidget {
  const SongAddToPlaylist({super.key, required this.playlist});
  final Playermodel playlist;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Song Add To Playlist',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
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
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 73,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: ListTile(
                          leading: QueryArtworkWidget(
                            id: item.data![index].id,
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
                              ),
                            ),
                            artworkBorder: BorderRadius.circular(10),
                            artworkFit: BoxFit.cover,
                          ),
                          title: Text(
                            item.data![index].displayNameWOExt,
                            maxLines: 1,
                            style: const TextStyle(color: kbackcolor),
                          ),
                          subtitle: Text(
                            item.data![index].artist!,
                            style: const TextStyle(color: kbackcolor),
                            maxLines: 1,
                          ),
                          trailing: Consumer<PlaylistProvider>(
                              builder: (context, data, _) {
                            return Wrap(
                              children: [
                                !playlist.isvalule(item.data![index].id)
                                    ? IconButton(
                                        onPressed: () {
                                          Getallsongs.copysong = item.data!;

                                          data.songaddplaylist(
                                              item.data![index],
                                              playlist,
                                              context);
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: kbackcolor,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          playlist
                                              .deletedata(item.data![index].id);
                                          snackBarWidget(
                                            ctx: context,
                                            title: 'Music Removed In Playlist',
                                            clr: kred,
                                          );
                                        },
                                        icon: const Icon(Icons.remove,
                                            color: kbackcolor),
                                      ),
                              ],
                            );
                          }),
                        ),
                      ));
                },
              );
            }),
      ),
    );
  }
}

final audioquery = OnAudioQuery();
