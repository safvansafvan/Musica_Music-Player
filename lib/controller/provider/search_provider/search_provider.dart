import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider extends ChangeNotifier {
  List<SongModel> totalsongs = [];
  List<SongModel> stillsongs = [];
  final OnAudioQuery audioQuery = OnAudioQuery();
  textupdatetextfield(String text) {
    List<SongModel> result = [];

    if (text.isEmpty) {
      result = totalsongs;
    } else {
      result = totalsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .trim()
              .contains(text.toLowerCase().trim()))
          .toList();
    }

    stillsongs = result;
    notifyListeners();
  }

  Future<void> fetchallsongs() async {
    totalsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    stillsongs = totalsongs;
    notifyListeners();
  }
}
