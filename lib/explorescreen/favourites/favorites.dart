import 'package:flutter/material.dart';
import 'package:musica/DB/Functions/functionfav.dart';
import 'package:musica/screens/allmusic/allmusiclisttile.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 37, 37, 54),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 37, 37, 54),
            elevation: 15,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white60,
                )),
            title: const Text(
              'Favourites',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white60,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white60,
                ),
                onPressed: () {},
              ),
            ],
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
                                fontSize: 28,
                                color: Colors.white70,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      } else {
                        final temp = favoritedata.reversed.toList();
                        favoritedata = temp.toSet().toList();
                        return Allmusiclisttile(songmodel: favoritedata,);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
