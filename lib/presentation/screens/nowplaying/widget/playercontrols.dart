import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musics/controller/core/core.dart';
import 'package:musics/controller/music_controller/getallsongcontroller.dart';
import 'package:musics/controller/provider/nowplaying_provider/nowplay_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Playercontrolers extends StatelessWidget {
  Playercontrolers(
      {super.key,
      required this.count,
      required this.firstsong,
      required this.lastsong,
      required this.songModel});
  final int count;
  final bool firstsong;
  final bool lastsong;
  final SongModel songModel;

  bool isplaying = true;

  bool isrepeat = false;

  bool isshuffle = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NowplayingScreenProvider>(context, listen: false)
          .songplaying = true;
    });
    return Consumer<NowplayingScreenProvider>(
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                isshuffle == false
                    ? value.onshufflemode()
                    : value.offshufflemode();
              },
              icon: StreamBuilder<bool>(
                stream: Getallsongs.audioPlayer.shuffleModeEnabledStream,
                builder: (context, snapshot) {
                  isshuffle = snapshot.data ?? false;
                  if (isshuffle) {
                    return Icon(
                      Icons.shuffle_rounded,
                      color: Colors.blue[100],
                    );
                  } else {
                    return const Icon(
                      Icons.shuffle_outlined,
                      color: kbackcolor,
                    );
                  }
                },
              ),
            ),
            firstsong
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 30,
                      color: kbackcolor,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      if (Getallsongs.audioPlayer.hasPrevious) {
                        Getallsongs.audioPlayer.seekToPrevious();
                      }
                    },
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 30,
                      color: kbackcolor,
                    ),
                  ),
            CircleAvatar(
              backgroundColor: kbackcolor,
              radius: 30,
              child: Consumer<NowplayingScreenProvider>(
                  builder: (context, data, _) {
                return IconButton(
                  onPressed: () {
                    if (Getallsongs.audioPlayer.playing) {
                      data.songPause();
                    } else {
                      data.songPlay();
                    }
                    data.playpause();
                  },
                  icon: Icon(
                    value.songplaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: white70,
                    size: 30,
                  ),
                );
              }),
            ),
            lastsong
                ? const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_next_rounded,
                      size: 30,
                      color: kbackcolor,
                    ))
                : IconButton(
                    onPressed: () {
                      if (Getallsongs.audioPlayer.hasNext) {
                        Getallsongs.audioPlayer.seekToNext();
                      }
                    },
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      size: 30,
                      color: kbackcolor,
                    )),
            IconButton(
              onPressed: () {
                Getallsongs.audioPlayer.loopMode == LoopMode.one
                    ? Getallsongs.audioPlayer.setLoopMode(LoopMode.all)
                    : Getallsongs.audioPlayer.setLoopMode(LoopMode.one);
              },
              icon: StreamBuilder<LoopMode>(
                stream: Getallsongs.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  final loopmode = snapshot.data;
                  if (LoopMode.one == loopmode) {
                    return Icon(
                      Icons.repeat_one_rounded,
                      color: Colors.blue[100],
                    );
                  } else {
                    return const Icon(
                      Icons.repeat_rounded,
                      color: kbackcolor,
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
