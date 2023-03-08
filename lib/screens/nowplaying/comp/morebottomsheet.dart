import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/DB/model/model.dart';
import 'package:musica/explorescreen/playlist/playlist.dart';
import 'package:musica/screens/songinfo/songinfo.dart';
import 'package:on_audio_query/on_audio_query.dart';

void showbottomsheet(BuildContext context, SongModel songModel) {
  showModalBottomSheet(
      backgroundColor: Colors.white70,
      context: context,
      builder: (ctx1) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 113,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.playlist_add,
                    color: Color.fromARGB(255, 37, 37, 54),
                  ),
                  title: const Text(
                    'Add Playlist',
                    style: TextStyle(
                      color: Color.fromARGB(255, 37, 37, 54),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    shoplaylistdialog(context, songModel);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline,
                      color: Color.fromARGB(255, 37, 37, 54)),
                  title: const Text(
                    'Song Info',
                    style: TextStyle(color: Color.fromARGB(255, 37, 37, 54)),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Songinfowidget(
                          songmodel: songModel,
                        );
                      },
                    ));
                  },
                ),
              ],
            ),
          ),
        );
      });
}

shoplaylistdialog(
  ctx,
  SongModel songModel,
) {
  showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      backgroundColor: const Color.fromARGB(207, 255, 255, 255),
      title: const Text(
        'Select Your Playlist',
        style: TextStyle(
          color: Color.fromARGB(255, 37, 37, 54),
        ),
      ),
      content: SizedBox(
        height: 200,
        width: double.infinity,
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Playermodel>('playlistdata').listenable(),
          builder: (context, Box<Playermodel> musiclist, child) {
            return Hive.box<Playermodel>('playlistdata').isEmpty
                ? const Center(
                    child: Text(
                    'No Playlist Found',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ))
                : ListView.builder(
                    itemCount: musiclist.length,
                    itemBuilder: (context, index) {
                      final data = musiclist.values.toList()[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue)),
                        child: ListTile(
                          onTap: () {
                            songaddtoplaylist(songModel, data, data.name, ctx);
                            Navigator.pop(context);
                          },
                          title: Text(
                            data.name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 37, 37, 54),
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 37, 37, 54),
                          ),
                        ),
                      );
                    });
          },
        ),
      ),
      actions: [
        Wrap(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  newplaylist(ctx, formkey);
                },
                child: const Text('New Playlist'))
          ],
        )
      ],
    ),
  );
}

void songaddtoplaylist(
    SongModel data, datas, String name, BuildContext context) {
  if (!datas.isvalule(data.id)) {
    datas.add(data.id);
    final snake1 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: const Color.fromARGB(222, 38, 46, 67),
        content: Center(
            child: Text(
          'Playlist Add To $name',
          style: const TextStyle(color: Colors.white60),
        )));
    ScaffoldMessenger.of(context).showSnackBar(snake1);
  } else {
    final snake2 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Center(child: Text('Song Alredy Added In $name')));
    ScaffoldMessenger.of(context).showSnackBar(snake2);
  }
}
