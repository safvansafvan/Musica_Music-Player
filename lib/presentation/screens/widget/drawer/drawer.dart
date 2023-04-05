import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musica/presentation/screens/profile/profile.dart';
import 'package:musica/controller/provider/profile_provider/profile_provider.dart';
import 'package:musica/presentation/screens/explorescreen/favourites/favorites.dart';
import 'package:musica/presentation/screens/explorescreen/playlist/playlist.dart';
import 'package:musica/presentation/screens/widget/settings/settings_pages/settings.dart';
import 'package:provider/provider.dart';
import '../../../../DB/profile_model/model/model.dart';
import '../../../../controller/core/core.dart';

// ignore: must_be_immutable
class Drawerwidget extends StatelessWidget {
  Drawerwidget({super.key});

  Profilemodel? user;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getdetails();
    });
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: Provider.of<ProfileProvider>(
                context,
              ).userprofilelist,
              builder: (context, userdata, child) {
                for (final x in userdata) {
                  user = x;
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 33,
                      backgroundImage: FileImage(File(user?.userimage ?? '')),
                    ),
                    title: Text(
                      user?.username.toUpperCase() ?? 'Update Profile',
                      style: const TextStyle(color: kbackcolor, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Profiewidget();
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 5,
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
                  border: Border.all(color: blueclr),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 27,
                  color: Colors.white70,
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
                    ),
                  );
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
                border: Border.all(color: blueclr),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.favorite,
                  size: 27,
                  color: Colors.white70,
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
                    ),
                  );
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
                  border: Border.all(color: blueclr),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: const Icon(
                  Icons.playlist_play_rounded,
                  size: 27,
                  color: Colors.white70,
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
                  border: Border.all(color: blueclr),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: const Icon(
                  Icons.settings,
                  size: 27,
                  color: Colors.white70,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsP(),
                      ));
                },
              ),
            ),
            const SizedBox(
              height: 370,
            ),
            const Text(
              'Version ',
              style: TextStyle(color: kbackcolor, fontWeight: FontWeight.w500),
            ),
            const Text(
              '1.1v ',
              style: TextStyle(color: kbackcolor, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
