import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/screens/allmusic/allmusiclisttile.dart';
import 'package:musica/widget/appbar/appbar.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Search',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CupertinoSearchTextField(
                onChanged: (value) => textupdatetextfield(value),
                padding: const EdgeInsets.all(12),
                style: textStyleFuc(
                    size: 15, clr: Colors.grey, bld: FontWeight.w500),
              ),
            ),
            stillsongs.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(top: 270),
                    child: Center(
                      child: Text(
                        'No Songs ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: kbackcolor),
                      ),
                    ),
                  )
                : Expanded(
                    child: Allmusiclisttile(
                      songmodel: stillsongs,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  textupdatetextfield(String text) {
    List<SongModel> result = [];

    if (text.isEmpty) {
      setState(() {
        result = totalsongs;
      });
    } else {
      result = totalsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .trim()
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
    setState(() {
      stillsongs = totalsongs;
    });
  }
}
