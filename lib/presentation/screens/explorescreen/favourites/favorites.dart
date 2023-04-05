import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/provider/favourite_provider/favourit_provider.dart';
import 'package:musica/presentation/screens/allmusic/allmusiclisttile.dart';
import 'package:provider/provider.dart';

import '../../widget/appbar/appbar.dart';

class Favoriteswidget extends StatelessWidget {
  const Favoriteswidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 693,
              child: Consumer<FavouriteProvider>(
                builder: (BuildContext context, data, Widget? child) {
                  if (data.favoitessongs.isEmpty) {
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
                    final temp = data.favoitessongs.reversed.toList();
                    data.favoitessongs = temp.toSet().toList();
                    return Allmusiclisttile(
                      songmodel: data.favoitessongs,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
