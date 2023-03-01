import 'package:flutter/material.dart';
import 'package:musica/controller/getallsongcontroller.dart';
import 'package:musica/screens/allmusic/allmusiclisttile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

List<SongModel> startsong = [];

class Allsongswidget extends StatefulWidget {
  const Allsongswidget({super.key});

  @override
  State<Allsongswidget> createState() => _AllsongswidgetState();
}

class _AllsongswidgetState extends State<Allsongswidget> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    bool status = await audioqury.permissionsStatus();
    if (!status) {
      await audioqury.permissionsRequest();
    }
    setState(() {});
    Permission.storage.request();
  }

  final audioqury = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
        future: audioqury.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true
            ),

        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text(
                'No songs',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            );
          }

          startsong = item.data!;

          // playlist
          Getallsongs.copysong = item.data!;

          return Allmusiclisttile(
            songmodel: item.data!,
          );
        });
  }
}
