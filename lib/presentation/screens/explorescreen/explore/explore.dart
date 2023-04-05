import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/presentation/screens/explorescreen/playlist/playlist.dart';
import '../../recentlyplayed/recently.dart';

class Explorescreen extends StatefulWidget {
  const Explorescreen({super.key});

  @override
  State<Explorescreen> createState() => _ExplorescreenState();
}

class _ExplorescreenState extends State<Explorescreen> {
  @override
  Widget build(BuildContext context) {
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
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/playlist.jpeg'),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Column(
                      children: const [
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
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Recently Played',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w500, color: kbackcolor),
            ),
          ),
          Recentwidget()
        ],
      ),
    );
  }
}
