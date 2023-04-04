import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionfav.dart';
import 'package:musica/DB/Functions/functionmostlyplayed.dart';
import 'package:musica/DB/Functions/recentlyplayed.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/widget/snack_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../provider/songmodelprovider.dart';
import '../nowplaying/comp/morebottomsheet.dart';
import '../nowplaying/nowplaying.dart';

// ignore: must_be_immutable
class Allmusiclisttile extends StatefulWidget {
  Allmusiclisttile({
    super.key,
    required this.songmodel,
  });
  List<SongModel> songmodel = [];

  @override
  State<Allmusiclisttile> createState() => _AllmusiclisttileState();
}

class _AllmusiclisttileState extends State<Allmusiclisttile> {
  List<SongModel> songs = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        songs.addAll(widget.songmodel);
        return Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 73,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue),
            ),
            child: ListTile(
              leading: QueryArtworkWidget(
                id: widget.songmodel[index].id,
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
              title: Text(widget.songmodel[index].displayNameWOExt,
                  maxLines: 1, style: const TextStyle(color: kbackcolor)),
              subtitle: Text(
                '${widget.songmodel[index].artist.toString() == "<unknown>" ? "Unknown Artist" : widget.songmodel[index].artist}',
                style: const TextStyle(color: kbackcolor),
                maxLines: 1,
              ),
              trailing: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white70,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.playlist_add,
                                    color: Color.fromARGB(255, 39, 33, 55)),
                                title: const Text(
                                  'Add playlist',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 39, 33, 55),
                                  ),
                                ),
                                onTap: () {
                                  shoplaylistdialog(
                                    context,
                                    widget.songmodel[index],
                                  );
                                },
                              ),
                              //2
                              ValueListenableBuilder(
                                valueListenable: FavoriteDB.favoitessongs,
                                builder:
                                    (context, List<SongModel> data, child) {
                                  return ListTile(
                                    title: Text(
                                      FavoriteDB.isfavo(widget.songmodel[index])
                                          ? 'Remove Favorites'
                                          : 'Add Favorites',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 39, 33, 55),
                                      ),
                                    ),
                                    onTap: () {
                                      if (FavoriteDB.isfavo(
                                          widget.songmodel[index])) {
                                        FavoriteDB.deletesong(
                                            widget.songmodel[index].id);
                                        snackBarWidget(
                                            ctx: context,
                                            title:
                                                'Song Removed In Favorate List',
                                            clr: Colors.red);
                                      } else {
                                        snackBarWidget(
                                            ctx: context,
                                            title:
                                                'Song Added In Favorate List',
                                            clr: blueclr);
                                        FavoriteDB.add(widget.songmodel[index]);
                                      }
                                      FavoriteDB.favoitessongs
                                          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                          .notifyListeners();

                                      Navigator.pop(context);
                                    },
                                    leading: FavoriteDB.isfavo(
                                            widget.songmodel[index])
                                        ? const Icon(Icons.favorite,
                                            color:
                                                Color.fromARGB(255, 39, 33, 55))
                                        : const Icon(
                                            Icons.favorite_border_outlined,
                                            color: Color.fromARGB(
                                                255, 39, 33, 55)),
                                  );
                                },
                              ),
                            ],
                          ));
                    },
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: kbackcolor,
                ),
              ),
              onTap: () {
                Mostlyplayedctl.addmostlyplayed(widget.songmodel[index].id);

                Recentcontroller.addrecentlyplayed(widget.songmodel[index].id);

                Getallsongs.audioPlayer.setAudioSource(
                    Getallsongs.createsongslist(widget.songmodel),
                    initialIndex: index);
                context
                    .read<Songmodelprovider>()
                    .setid(widget.songmodel[index].id);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Nowplaying(
                          songModel: widget.songmodel,
                          count: widget.songmodel.length,
                        )));
              },
            ),
          ),
        );
      },
      itemCount: widget.songmodel.length,
    );
  }
}
