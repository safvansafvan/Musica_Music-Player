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
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/miniplayerb.jpg')),
              border:
                  Border.all(color: const Color.fromARGB(130, 33, 149, 243)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                            color: Colors.white60,
                          );
                        } else {
                          return const Icon(
                            Icons.play_arrow,
                            color: Colors.white60,
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
                    icon: const Icon(Icons.skip_next, color: Colors.white54))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
