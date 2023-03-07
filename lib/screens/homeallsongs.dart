import 'package:flutter/material.dart';
import 'package:musica/DB/Fuctionprofile/func.dart';
import 'package:musica/components/drawer.dart';
import 'package:musica/controller/getallsongcontroller.dart';
import 'package:musica/explorescreen/explore/explore.dart';
import 'package:musica/search/search.dart';
import 'package:musica/widget/mniplayer.dart';
import 'package:musica/widget/mostplayed.dart';
import 'allmusic/allmusic.dart';

class Allsongs extends StatefulWidget {
  const Allsongs({super.key});

  @override
  State<Allsongs> createState() => _AllsongsState();
}

class _AllsongsState extends State<Allsongs> {
  int bottomnavindexnum = 0;
  List tabbarwidget = const [Allsongswidget(), Mostplayed(), Explorescreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 33, 55),
      appBar: AppBar(
        elevation: 15,
        backgroundColor: const Color.fromARGB(255, 39, 33, 55),
        title: const Text(
          'Musica',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Searchwidget(),
                ));
              },
              icon: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              )),
        ],
      ),
      body: Stack(
        children: [
          tabbarwidget[bottomnavindexnum],
          Positioned(
              bottom: 0,
              child: Column(children: [
                Getallsongs.audioPlayer.currentIndex != null
                    ? StreamBuilder<bool>(
                      stream: Getallsongs.audioPlayer.playingStream,
                      builder: (context, snapshot) {
                        
                        return const Miniplayers();
                      }
                    )
                    : Container()  
              ]))
        ],
      ),
      drawer: const Drawer(
          backgroundColor: Color.fromARGB(201, 25, 21, 36),
          child: Drawerwidget()),

      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        elevation: 15,
        backgroundColor: const Color.fromARGB(111, 39, 33, 55),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.music_video,
              color: Colors.white60,
            ),
            label: 'All Music',
          ),
          BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 42, 35, 58),
              icon: Icon(
                Icons.topic_sharp,
                color: Colors.white60,
              ),
              label: 'Mostly Played'),
          BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 42, 35, 58),
              icon: Icon(
                Icons.explore,
                color: Colors.white60,
              ),
              label: 'Explore')
        ],
        currentIndex: bottomnavindexnum,
        onTap: (int index) {
          setState(() {
            bottomnavindexnum = index;
          });
        },
      ),
    );
  }
}
