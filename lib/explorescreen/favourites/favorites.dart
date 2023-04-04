import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionfav.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/screens/allmusic/allmusiclisttile.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../widget/appbar/appbar.dart';

class Favoriteswidget extends StatefulWidget {
  const Favoriteswidget({super.key});

  @override
  State<Favoriteswidget> createState() => _FavoriteswidgetState();
}

class _FavoriteswidgetState extends State<Favoriteswidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavoriteDB.favoitessongs,
      builder: (context, List<SongModel> favoritedata, child) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 55),
              child: AppBarWidget(
                  titles: 'Favourites',
                  leading: Icons.arrow_back_ios,
                  trailing: Icons.search,
                  search: true,
                  menu: false),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 693,
                    child: ValueListenableBuilder(
                      valueListenable: FavoriteDB.favoitessongs,
                      builder: (BuildContext context,
                          List<SongModel> favoritedata, Widget? child) {
                        if (favoritedata.isEmpty) {
                          return const Center(
                            child: Text(
                              'No songs in favourites',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: kbackcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        } else {
                          final temp = favoritedata.reversed.toList();
                          favoritedata = temp.toSet().toList();
                          return Allmusiclisttile(
                            songmodel: favoritedata,
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
