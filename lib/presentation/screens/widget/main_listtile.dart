import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/controller/provider/mostly_p_provider/mostly_provider.dart';
import 'package:musica/controller/provider/provider_nowp_image/songmodelprovider.dart';
import 'package:musica/controller/provider/recently__provider/recently_provider.dart';
import 'package:musica/presentation/screens/nowplaying/nowplaying.dart';
import 'package:musica/presentation/screens/widget/more_bottom_sheet/bottom_sheet.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MusicListTile extends StatelessWidget {
  MusicListTile(
      {super.key,
      required this.songmodel,
      this.recentlylength,
      this.isRecently = false,
      this.isMosltly = false});

  final List<SongModel> songmodel;

  final dynamic recentlylength;
  final bool isRecently;
  final bool isMosltly;

  final List<SongModel> songs = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(keepScrollOffset: true),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
                    backgroundColor: white70,
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
                Provider.of<MostlyPlayedProvider>(context, listen: false)
                    .addmostlyplayed(songmodel[index].id);

                Provider.of<RecentlyProvider>(context, listen: false)
                    .addrecentlyplayed(songmodel[index].id);

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
      itemCount: isRecently || isMosltly ? recentlylength : songmodel.length,
    );
  }
}
