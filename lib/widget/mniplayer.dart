import 'package:flutter/material.dart';
import 'package:musica/controller/getallsongcontroller.dart';
import 'package:musica/screens/nowplaying/nowplaying.dart';
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
      if (index == null && mounted) {
        setState(() {
          index == 0 ? firstsong = true : firstsong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: 340,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 74, 69, 87),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                children: 
                  [Row(
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
                                  style: const TextStyle(color: Colors.white60),
                                  
                                );
                              } else {
                                return Text(
                                  Getallsongs
                                      .playsong[
                                          Getallsongs.audioPlayer.currentIndex!]
                                      .displayNameWOExt,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white60),
                                );
                              }
                            }),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      firstsong
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white54,
                              ))
                          : IconButton(
                              onPressed: () {
                                if (Getallsongs.audioPlayer.hasPrevious) {
                                  Getallsongs.audioPlayer.seekToPrevious();
                                }
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white54,
                              )),
              
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                isplaying = !isplaying;
                              });
                              if (Getallsongs.audioPlayer.playing) {
                                Getallsongs.audioPlayer.pause();
                              } else {
                                Getallsongs.audioPlayer.play();
                              }
                            },
                            icon: Icon(
                              isplaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white60,
                            )),
                      ),
              
                      // CircleAvatar(
                      //   child: IconButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           if (mounted) {
                      //             setState(() {
                      //               Getallsongs.audioPlayer.playing;
                      //               Getallsongs.audioPlayer.pause();
                      //             });
                      //           } else {
                      //             Getallsongs.audioPlayer.play();
                      //           }
                      //           isplaying = isplaying;
                      //         });
                      //       },
                      //       icon: Icon(
                      //   isplaying ?
              
                      //   Icons.play_arrow : Icons.pause,
                      //   color: Colors.white60,
                      // )),
                      // ),
              
                      IconButton(
                          onPressed: () {
                            if (Getallsongs.audioPlayer.hasNext) {
                              Getallsongs.audioPlayer.seekToNext();
                            }
                          },
                          icon: const Icon(Icons.skip_next, color: Colors.white54))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
