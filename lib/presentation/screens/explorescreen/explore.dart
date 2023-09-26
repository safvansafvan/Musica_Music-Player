import 'package:flutter/material.dart';
import 'package:musics/controller/core/core.dart';
import 'package:musics/presentation/screens/explorescreen/playlist/playlist.dart';
import 'recentlyplayed/recently.dart';

class Explorescreen extends StatelessWidget {
  const Explorescreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appBodyColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Playlistwidget(),
                  ),
                );
              },
              child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(24)),
                child: Container(
                  height: screenheight * 0.27,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/playlist.jpeg'),
                        fit: BoxFit.fill),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Column(
                      children: [
                        Icon(
                          Icons.playlist_add,
                          color: Colors.white70,
                          size: 50,
                        ),
                        Text(
                          'Create Playlist',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Recently Played',
              style:
                  textStyleFuc(size: 22, clr: kbackcolor, bld: FontWeight.w500),
            ),
          ),
          Recentwidget()
        ],
      ),
    );
  }
}
