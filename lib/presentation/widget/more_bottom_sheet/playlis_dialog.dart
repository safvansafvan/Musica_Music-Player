import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musics/model/model/model.dart';
import 'package:musics/controller/core/core.dart';
import 'package:musics/presentation/screens/explorescreen/playlist/playlist.dart';
import 'package:musics/presentation/widget/snack_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../screens/explorescreen/playlist/widget/dialog_function.dart';

showPlayListDialogNowPlayScreen(ctx, SongModel songModel) {
  showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      backgroundColor: dialogcolor,
      title: const Text(
        'Select Your Playlist',
        style: TextStyle(color: white70),
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
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: white70),
                    ),
                  )
                : ListView.builder(
                    itemCount: musiclist.length,
                    itemBuilder: (context, index) {
                      final data = musiclist.values.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: blueclr),
                          ),
                          child: ListTile(
                            onTap: () {
                              songaddtoplaylist(
                                  songModel, data, data.name, ctx);
                              Navigator.pop(context);
                            },
                            title: Text(
                              data.name,
                              style: const TextStyle(
                                  color: white70, fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.add, color: white70),
                          ),
                        ),
                      );
                    },
                  );
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
              child: const Text('New Playlist'),
            )
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
    snackBarWidget(ctx: context, title: 'Playlist Add To $name', clr: blueclr);
  } else {
    snackBarWidget(
        ctx: context, title: 'Song Alredy Added In $name', clr: Colors.red);
  }
}
