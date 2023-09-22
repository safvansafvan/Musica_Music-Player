import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/provider/favourite_provider/favourit_provider.dart';
import 'package:musica/presentation/widget/snack_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'playlis_dialog.dart';

// ignore: must_be_immutable
class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({super.key, required this.songmodel, required this.index});

  SongModel songmodel;
  int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
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
              showPlayListDialogNowPlayScreen(context, songmodel);
            },
          ),
          //2
          Consumer<FavouriteProvider>(
            builder: (context, data, _) {
              return ListTile(
                title: Text(
                  data.isfavo(songmodel) ? 'Remove Favorites' : 'Add Favorites',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 39, 33, 55),
                  ),
                ),
                onTap: () {
                  if (data.isfavo(songmodel)) {
                    data.deletesong(songmodel.id);
                    snackBarWidget(
                        ctx: context,
                        title: 'Song Removed In Favorate List',
                        clr: Colors.red);
                  } else {
                    snackBarWidget(
                        ctx: context,
                        title: 'Song Added In Favorate List',
                        clr: blueclr);
                    data.add(songmodel);
                  }
                  data.favoitessongs;
                  Navigator.pop(context);
                },
                leading: data.isfavo(songmodel)
                    ? const Icon(Icons.favorite,
                        color: Color.fromARGB(255, 39, 33, 55))
                    : const Icon(
                        Icons.favorite_border_outlined,
                        color: Color.fromARGB(255, 39, 33, 55),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
