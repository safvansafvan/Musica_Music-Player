import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionfav.dart';
import 'package:musica/DB/Functions/functionmostlyplayed.dart';
import 'package:musica/DB/Functions/recentlyplayed.dart';
import 'package:musica/controller/getallsongcontroller.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../provider/songmodelprovider.dart';
import '../nowplaying/comp/morebottomsheet.dart';
import '../nowplaying/nowplaying.dart';

class Allmusiclisttile extends StatefulWidget {
  Allmusiclisttile({super.key, required this.songmodel,});
  List<SongModel> songmodel = [];

 
  @override
  State<Allmusiclisttile> createState() => _AllmusiclisttileState();
}

class _AllmusiclisttileState extends State<Allmusiclisttile> {
  List<SongModel> songs = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
       songs.addAll(widget.songmodel);
        return SizedBox(
          height: 65,
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
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white60,
                  )),
              artworkBorder: BorderRadius.circular(10),
              artworkFit: BoxFit.cover,
            ),
           title: Text(widget.songmodel[index].displayNameWOExt,
            // .substring(0,1).toLowerCase()+ widget.songmodel[index].displayNameWOExt.substring(1),
           
                maxLines: 1, style: const TextStyle(color: Colors.white70)),
            subtitle: Text(
              '${widget.songmodel[index].artist}',
              style: const TextStyle(color: Colors.white70),
              maxLines: 1,
            ),
            trailing: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white70,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                          height: 180,
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
                                 shoplaylistdialog(context,widget.songmodel[index],);
                                  
                                },
                              ),
                              //2
                              ValueListenableBuilder(
                                valueListenable: FavoriteDB.favoitessongs,
                                builder:
                                    (context, List<SongModel> data, child) {
                                  return ListTile(
                                    // leading:const Icon(Icons.favorite_outline,
                                    //     color: Color.fromARGB(
                                    //         255, 39, 33, 55)),
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
                                        const remove = SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(222, 38, 46, 67),
                                          content: Center(
                                            child: Text(
                                              'Song Removed In Favorate List',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white70),
                                            ),
                                          ),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(remove);
                                      } else {
                                        FavoriteDB.add(widget.songmodel[index]);
                                        const add = SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(222, 38, 46, 67),
                                          content: Center(
                                              child: Center(
                                            child: Text(
                                              'Song Added In Favorate List',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white70),
                                            ),
                                          )),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(add);
                                      }
                                      FavoriteDB.favoitessongs
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
                              //3
                              ListTile(
                                leading: const Icon(Icons.info_outline,
                                    color: Color.fromARGB(255, 39, 33, 55)),
                                title: const Text(
                                  'Song info',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 39, 33, 55),
                                  ),
                                ),
                                onTap: () {},
                              ),
                              //4
                              
                              
                            ],
                          ));
                    },
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white60,
                )),
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
        );
      },
      itemCount: widget.songmodel.length,
      controller: ScrollController(keepScrollOffset: true),
    );
  }
}
