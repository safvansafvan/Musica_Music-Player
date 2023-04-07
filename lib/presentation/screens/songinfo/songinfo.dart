import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/presentation/screens/widget/appbar/appbar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../widget/main_artwork.dart';

// ignore: must_be_immutable
class Songinfowidget extends StatelessWidget {
  Songinfowidget(
      {super.key,
      required this.songmodel,
      required this.widget,
      required this.index});
  final SongModel songmodel;
  // ignore: prefer_typing_uninitialized_variables
  final widget;
  int index;

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Song Info',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              SizedBox(
                height: screenheight * 0.03,
              ),
              Artworkwidget(widget: widget, currentindex: index),
              SizedBox(
                height: screenheight * 0.05,
              ),
              Text(
                'Title:${songmodel.title}',
                style: const TextStyle(
                  color: kbackcolor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenheight * 0.05,
              ),
              Text(
                'Artist: ${songmodel.artist == '<unknown>' ? 'Unknown Artist' : songmodel.artist}',
                style: const TextStyle(color: kbackcolor),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
