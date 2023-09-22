import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/presentation/screens/nowplaying/nowplaying.dart';
import 'package:text_scroll/text_scroll.dart';

class Miniplayers extends StatefulWidget {
  const Miniplayers({super.key});

  @override
  State<Miniplayers> createState() => _MiniplayersState();
}

bool firstsong = false;
bool isplaying = false;

class _MiniplayersState extends State<Miniplayers> {
  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          index == 0 ? firstsong = true : firstsong = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return Nowplaying(
              songModel: Getallsongs.playsong,
            );
          },
        ));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.96,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/im.jpg'),
              ),
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: StreamBuilder<bool>(
                        stream: Getallsongs.audioPlayer.playingStream,
                        builder: (context, snapshot) {
                          bool? playingstage = snapshot.data;
                          if (playingstage != null && playingstage) {
                            return TextScroll(
                              Getallsongs
                                  .playsong[
                                      Getallsongs.audioPlayer.currentIndex!]
                                  .displayNameWOExt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: kwhite, fontWeight: FontWeight.w500),
                            );
                          } else {
                            return Text(
                              Getallsongs
                                  .playsong[
                                      Getallsongs.audioPlayer.currentIndex!]
                                  .displayNameWOExt,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500,
                                  color: kbackcolor),
                            );
                          }
                        }),
                  ),
                  firstsong
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous,
                            color: kbackcolor,
                          ))
                      : IconButton(
                          onPressed: () {
                            if (Getallsongs.audioPlayer.hasPrevious) {
                              Getallsongs.audioPlayer.seekToPrevious();
                            }
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            color: kbackcolor,
                          )),
                  CircleAvatar(
                    backgroundColor: Colors.black87,
                    child: IconButton(
                      onPressed: () async {
                        setState(() {
                          isplaying = !isplaying;
                        });
                        if (Getallsongs.audioPlayer.playing) {
                          await Getallsongs.audioPlayer.pause();
                        } else {
                          await Getallsongs.audioPlayer.play();
                        }
                      },
                      icon: StreamBuilder<bool>(
                        stream: Getallsongs.audioPlayer.playingStream,
                        builder: (context, snapshot) {
                          bool? stage = snapshot.data;
                          if (stage != null && stage) {
                            return const Icon(
                              Icons.pause,
                              color: white70,
                            );
                          } else {
                            return const Icon(
                              Icons.play_arrow,
                              color: white70,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (Getallsongs.audioPlayer.hasNext) {
                        Getallsongs.audioPlayer.seekToNext();
                      }
                    },
                    icon: const Icon(Icons.skip_next, color: kbackcolor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
