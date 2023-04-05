import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionmostlyplayed.dart';
import 'package:musica/DB/Functions/recentlyplayed.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/screens/allmusic/widget/bottom_sheet.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../provider/songmodelprovider.dart';
import '../nowplaying/nowplaying.dart';

// ignore: must_be_immutable
class Allmusiclisttile extends StatelessWidget {
  Allmusiclisttile({
    super.key,
    required this.songmodel,
  });
  List<SongModel> songmodel = [];

  List<SongModel> songs = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        songs.addAll(songmodel);
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
                id: songmodel[index].id,
                type: ArtworkType.AUDIO,
                artworkHeight: 60,
                artworkWidth: 60,
                nullArtworkWidget: Container(
                  height: 60,
                  width: 60,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: const Icon(
                    Icons.music_note,
                    color: kbackcolor,
                  ),
                ),
                artworkBorder: BorderRadius.circular(10),
                artworkFit: BoxFit.cover,
              ),
              title: Text(songmodel[index].displayNameWOExt,
                  maxLines: 1, style: const TextStyle(color: kbackcolor)),
              subtitle: Text(
                '${songmodel[index].artist.toString() == "<unknown>" ? "Unknown Artist" : songmodel[index].artist}',
                style: const TextStyle(color: kbackcolor),
                maxLines: 1,
              ),
              trailing: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white70,
                    context: context,
                    builder: (context) {
                      return BottomSheetWidget(
                        songmodel: songmodel[index],
                        index: index,
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: kbackcolor,
                ),
              ),
              onTap: () {
                Mostlyplayedctl.addmostlyplayed(songmodel[index].id);

                Recentcontroller.addrecentlyplayed(songmodel[index].id);

                Getallsongs.audioPlayer.setAudioSource(
                    Getallsongs.createsongslist(songmodel),
                    initialIndex: index);
                context.read<Songmodelprovider>().setid(songmodel[index].id);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Nowplaying(
                      songModel: songmodel,
                      count: songmodel.length,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      itemCount: songmodel.length,
    );
  }
}
