import 'package:flutter/material.dart';
import 'package:musica/screens/allmusic/allmusiclisttile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Searchwidget extends StatefulWidget {
  const Searchwidget({super.key});

  @override
  State<Searchwidget> createState() => _SearchwidgetState();
}

List<SongModel> totalsongs = [];
List<SongModel> stillsongs = [];
final OnAudioQuery audioQuery = OnAudioQuery();

class _SearchwidgetState extends State<Searchwidget> {
  @override
  void initState() {
    fetchallsongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 33, 55),
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromARGB(255, 39, 33, 55),
                )),
            title: TextField(
              onChanged: (value) => textupdatetextfield(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search ',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 39, 33, 55),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 39, 33, 55),
                  )),
            ),
            elevation: 15,
            backgroundColor: Colors.blue[100]),
        body: stillsongs.isEmpty
            ? const Center(
                child: Text(
                'No Songs ',
                style: TextStyle(fontSize: 20, color: Colors.white60),
              ))
            : Allmusiclisttile(
                songmodel: stillsongs,
              ));
  }

  textupdatetextfield(String text) {
    List<SongModel> result = [];
    if (text.isEmpty) {
      result = totalsongs;
    } else {
      result = totalsongs
          .where((element) => element.displayNameWOExt.toLowerCase().trim()
              .contains(text.toLowerCase().trim()))
          .toList();
    }
    setState(() {
      stillsongs = result;
    });
  }

  Future<void> fetchallsongs() async {
    totalsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }
}
