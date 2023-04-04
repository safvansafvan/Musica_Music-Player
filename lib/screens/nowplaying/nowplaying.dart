import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionfav.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/screens/nowplaying/playercontrols.dart';
import 'package:musica/widget/appbar/appbar.dart';
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: appBodyColor,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 55),
            child: AppBarWidget(
                titles: 'Audizi Player',
                leading: Icons.arrow_back_ios,
                trailing: Icons.error,
                search: false,
                menu: false),
          ),
          body: SizedBox(
            height: double.infinity,
            child: ListView(children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Artworkwidget(
                  widget: widget,
                  currentindex: currentindex,
                ),
              ),
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
                            color: kbackcolor,
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
                          color: kbackcolor,
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
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: kbackcolor),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showbottomsheet(
                            context, widget.songModel[currentindex]);
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: kbackcolor,
                      )),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      position.toString().split('.')[0],
                      style: const TextStyle(color: kbackcolor),
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
                    activeColor: kbackcolor,
                    thumbColor: kbackcolor,
                    inactiveColor: kbackcolor,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      duration.toString().split('.')[0],
                      style: const TextStyle(color: kbackcolor),
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
          )),
    );
  }

  void chagetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Getallsongs.audioPlayer.seek(duration);
  }
}
