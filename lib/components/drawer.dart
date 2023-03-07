import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musica/DB/Fuctionprofile/func.dart';
import 'package:musica/components/draweroptions/profile.dart';
import 'package:musica/explorescreen/favourites/favorites.dart';
import 'package:musica/explorescreen/playlist/playlist.dart';
import 'package:musica/widget/settings/set/settings.dart';
import '../DB/Fuctionprofile/model/model.dart';

class Drawerwidget extends StatefulWidget {
  const Drawerwidget({super.key});

  @override
  State<Drawerwidget> createState() => _DrawerwidgetState();
}

class _DrawerwidgetState extends State<Drawerwidget> {
  Profilemodel? user;
  @override
  void initState() {
    super.initState();
    getdetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      ValueListenableBuilder(
        valueListenable: profilenotifier,
        builder: (context, userdata, child) {
          for (final x in userdata) {
            user = x;
          }
          return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: 
              ListTile(
                leading: CircleAvatar(
                  
                  radius: 33,
                  backgroundImage:
                      FileImage(File(user?.userimage ?? '${const Icon(Icons.person,color: Colors.white60,)}')),
                ),
                title: Text(
                  user?.username ?? 'Update Profile',
                  style: const TextStyle(color: Colors.white60, fontSize: 15),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const Profiewidget();
                    },
                  ));
                },
              ));
        },
      ),

      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Divider(
          thickness: 1,
          color: Colors.white54,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        width: 285,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/profile.jpg')),
            color: Colors.blue[200],
            border: Border.all(color: Colors.white60),
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: const Icon(
            Icons.person,
            size: 27,
            color: Colors.white,
          ),
          title: const Text(
            'Profile',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profiewidget(),
                ));
          },
        ),
      ),
      const SizedBox(
        height: 5,
      ),

      Container(
        width: 285,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/favourites.jpeg')),
            color: Colors.blue[200],
            border: Border.all(color: Colors.white60),
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: const Icon(
            Icons.favorite,
            size: 27,
            color: Colors.white,
          ),
          title: const Text(
            'Favourites',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Favoriteswidget(),
                ));
          },
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        width: 285,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/playlist.jpeg')),
            color: Colors.blue[200],
            border: Border.all(color: Colors.white60),
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: const Icon(
            Icons.playlist_play_rounded,
            size: 27,
            color: Colors.white,
          ),
          title: const Text(
            'Playlist',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Playlistwidget(),
                ));
          },
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        width: 285,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/settings.webp')),
            color: Colors.blue[200],
            border: Border.all(color: Colors.white60),
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: const Icon(
            Icons.settings,
            size: 27,
            color: Colors.white,
          ),
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Settigs(),
                ));
          },
        ),
      ),
      const SizedBox(
        height: 370,
      ),
      const Text(
        'Version ',
        style: TextStyle(color: Colors.white54),
      ),
      const Text(
        '1.0v ',
        style: TextStyle(color: Colors.white54),
      )
    ]));
  }
}
