import 'package:flutter/material.dart';
import 'package:musics/controller/core/core.dart';
import 'package:musics/controller/music_controller/getallsongcontroller.dart';
import 'package:musics/controller/provider/favourite_provider/favourit_provider.dart';
import 'package:musics/presentation/screens/homeallsongs.dart';
import 'package:musics/presentation/screens/nowplaying/widget/playercontrols.dart';
import 'package:musics/presentation/screens/nowplaying/widget/song_durations_controller.dart';
import 'package:musics/presentation/screens/songinfo/songinfo.dart';
import 'package:musics/presentation/widget/more_bottom_sheet/playlis_dialog.dart';
import 'package:musics/presentation/widget/snack_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../widget/main_artwork.dart';

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
  int currentindex = 0;
  bool firstsong = false;
  bool lastsong = false;
  int large = 0;

  Duration duration = const Duration();
  Duration position = const Duration();

  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen((ind) {
      if (ind != null) {
        Getallsongs.currentindexgetallsongs = ind;
        if (mounted) {
          setState(
            () {
              large = widget.count - 1;
              currentindex = ind;
              ind == 0 ? firstsong = true : firstsong = false;
              ind == large ? lastsong = true : lastsong = false;
            },
          );
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
    var screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: ListTile(
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return const Allsongs();
                  },
                ), (route) => false);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              'Music Player',
              style:
                  textStyleFuc(size: 18, clr: kbackcolor, bld: FontWeight.w500),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Songinfowidget(
                        widget: widget,
                        index: currentindex,
                        songmodel: widget.songModel[currentindex],
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.info_outline_rounded),
            ),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          child: ListView(
            children: [
              SizedBox(
                height: screenheight * 0.06,
              ),
              Center(
                child: Artworkwidget(
                  widget: widget,
                  currentindex: currentindex,
                ),
              ),
              SizedBox(
                height: screenheight * 0.03,
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
                    SizedBox(
                      height: screenheight * 0.01,
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
              SizedBox(
                height: screenheight * 0.1,
              ),
              Consumer<FavouriteProvider>(builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (value.isfavo(widget.songModel[currentindex])) {
                          value.deletesong(widget.songModel[currentindex].id);
                          snackBarWidget(
                              ctx: context,
                              title: 'Song Removed In Favourite List',
                              clr: kred);
                        } else {
                          value.add(widget.songModel[currentindex]);
                          snackBarWidget(
                              ctx: context,
                              title: 'Song Added In Favourite List',
                              clr: blueclr);
                        }
                      },
                      icon: Icon(
                          Provider.of<FavouriteProvider>(context, listen: false)
                                  .isfavo(widget.songModel[currentindex])
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: kbackcolor),
                    ),
                    IconButton(
                      onPressed: () {
                        showPlayListDialogNowPlayScreen(
                            context, widget.songModel[currentindex]);
                      },
                      icon: const Icon(
                        Icons.playlist_add_circle_outlined,
                        color: kbackcolor,
                      ),
                    ),
                  ],
                );
              }),
              SongDurationsController(
                position: position,
                duration: duration,
              ),
              //row
              Playercontrolers(
                count: widget.count,
                firstsong: firstsong,
                lastsong: lastsong,
                songModel: widget.songModel[currentindex],
              )
            ],
          ),
        ),
      ),
    );
  }
}
