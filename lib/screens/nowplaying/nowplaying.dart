import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionfav.dart';
import 'package:musica/controller/getallsongcontroller.dart';
import 'package:musica/screens/nowplaying/playercontrols.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'artworkwidget.dart';
import 'comp/morebottomsheet.dart';

class Nowplaying extends StatefulWidget {
  const Nowplaying({
    super.key,
    required this.songModel,
    this.count = 0,
  });
  final List<SongModel> songModel;
  final int count;

  @override
  State<Nowplaying> createState() => _NowplatingState();
}

class _NowplatingState extends State<Nowplaying> {
  Duration duration = const Duration();
  Duration position = const Duration();

  int currentindex = 0;
  bool firstsong = false;
  bool lastsong = false;
  int large = 0;

  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen((ind) {
      if (ind != null) {
        Getallsongs.currentindexgetallsongs = ind;
        if (mounted) {
          setState(() {
            large = widget.count - 1;
            currentindex = ind;
            ind == 0 ? firstsong = true : firstsong = false;
            ind == large ? lastsong = true : lastsong = false;
          });
        }
      }
    });
    super.initState();
    playsong();
  }

  void playsong() {
    Getallsongs.audioPlayer.play();
    Getallsongs.audioPlayer.durationStream.listen((D) {
      setState(() {
        duration = D!;
      });
    });
    Getallsongs.audioPlayer.positionStream.listen((P) {
      setState(() {
        position = P;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 33, 55),
        appBar: AppBar(
          elevation: 15,
         backgroundColor: const Color.fromARGB(255, 39, 33, 55),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white60,
              )),
          title: const Text(
            'Musica',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            // color: const Color.fromARGB(255, 39, 33, 55),
            child: ListView(children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                  child: Artworkwidget(
                widget: widget,
                currentindex: currentindex,
              )),
              // Container(
              //   height: 250,
              //   width: 250,
              //   decoration: BoxDecoration(
              //       color: Colors.red[100],
              //       borderRadius: const BorderRadius.all(Radius.circular(30))),
              // ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.songModel[currentindex].displayNameWOExt,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white60,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.songModel[currentindex].artist.toString() ==
                              "<unknown>"
                          ? "Unknown Artist"
                          : widget.songModel[currentindex].artist.toString(),
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white38,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: IconButton(
                      onPressed: () {
                        if (FavoriteDB.isfavo(widget.songModel[currentindex])) {
                          FavoriteDB.deletesong(
                              widget.songModel[currentindex].id);
                          const remove = SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Color.fromARGB(222, 38, 46, 67),
                            content: Center(
                              child: Text(
                                'Song Removed In Favorate List',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70),
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(remove);
                        } else {
                          FavoriteDB.add(widget.songModel[currentindex]);
                          const add = SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Color.fromARGB(222, 38, 46, 67),
                            content: Center(
                              child: Text(
                                'Song Added In Favorate List',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70),
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(add);
                        }
                      },
                      icon: Icon(
                          FavoriteDB.isfavo(widget.songModel[currentindex])
                              ?  Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: Colors.white60),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showbottomsheet(
                            context, widget.songModel[currentindex]);
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white70,
                      )),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      position.toString().split('.')[0],
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ),
                  Expanded(
                      child: Slider(
                    min: const Duration(microseconds: 0).inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    max: duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        chagetoseconds(value.toInt());
                        value = value;
                      });
                    },
                    activeColor: Colors.white60,
                    thumbColor: Colors.white70,
                    inactiveColor: Colors.white60,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      duration.toString().split('.')[0],
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ),
                ],
              ),
              //row
              Playercontroler(
                  count: widget.count,
                  firstsong: firstsong,
                  lastsong: lastsong,
                  songModel: widget.songModel[currentindex])
            ]),
          ),
        ));
  }

  void chagetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Getallsongs.audioPlayer.seek(duration);
  }
}
