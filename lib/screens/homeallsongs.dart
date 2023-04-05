import 'package:flutter/material.dart';
import 'package:musica/components/drawer.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/music_controller/getallsongcontroller.dart';
import 'package:musica/screens/explorescreen/explore/explore.dart';
import 'package:musica/widget/appbar/appbar.dart';
import 'package:musica/widget/mniplayer.dart';
import 'package:musica/screens/mostlyplayed/mostplayed.dart';
import 'allmusic/allmusic.dart';

class Allsongs extends StatefulWidget {
  const Allsongs({super.key});

  @override
  State<Allsongs> createState() => _AllsongsState();
}

class _AllsongsState extends State<Allsongs> {
  int bottomnavindexnum = 0;
  List tabbarwidget = [Allsongswidget(), Mostplayed(), const Explorescreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Audizi Player',
              leading: Icons.menu,
              trailing: Icons.search,
              search: true,
              menu: true),
        ),
        body: Stack(
          children: [
            tabbarwidget[bottomnavindexnum],
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Getallsongs.audioPlayer.currentIndex != null
                      ? StreamBuilder<bool>(
                          stream: Getallsongs.audioPlayer.playingStream,
                          builder: (context, snapshot) {
                            return const Miniplayers();
                          })
                      : Container()
                ],
              ),
            ),
          ],
        ),
        drawer: const Drawer(
          backgroundColor: Colors.white60,
          child: Drawerwidget(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          elevation: 15,
          backgroundColor: white70,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.music_video,
                color: kbackcolor,
              ),
              label: 'All Music',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.topic_sharp,
                  color: kbackcolor,
                ),
                label: 'Mostly Played'),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore, color: kbackcolor),
              label: 'Explore',
            )
          ],
          currentIndex: bottomnavindexnum,
          onTap: (int index) {
            setState(() {
              bottomnavindexnum = index;
            });
          },
        ),
      ),
    );
  }
}
