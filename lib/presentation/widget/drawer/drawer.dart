import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musics/model/profile_model/model/model.dart';
import 'package:musics/presentation/screens/profile/profile.dart';
import 'package:musics/controller/provider/profile_provider/profile_provider.dart';
import 'package:musics/presentation/screens/favourites/favorites.dart';
import 'package:musics/presentation/screens/explorescreen/playlist/playlist.dart';
import 'package:musics/presentation/screens/settings/settings.dart';
import 'package:musics/presentation/widget/snack_bar.dart';
import 'package:provider/provider.dart';
import '../../../controller/core/core.dart';

// ignore: must_be_immutable
class Drawerwidget extends StatelessWidget {
  Drawerwidget({
    super.key,
  });

  Profilemodel? user;
  bool status = true;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getdetails();
      if (user?.userimage == null) {
        status = true;
      } else {
        status = false;
      }
    });
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable:
                  Provider.of<ProfileProvider>(context).userprofilelist,
              builder: (context, userdata, child) {
                for (final x in userdata) {
                  user = x;
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child:
                      Consumer<ProfileProvider>(builder: (context, value, _) {
                    return ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: status
                            ? Image.asset(
                                'assets/images/profileq.jpeg',
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(
                                  user!.userimage,
                                ),
                                fit: BoxFit.cover,
                              ),
                      ),
                      title: Text(
                        user?.username.toUpperCase() ?? 'Update Profile',
                        style: const TextStyle(color: kbackcolor, fontSize: 15),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          value.delete(value.userprofilelist.value.length - 1);
                          snackBarWidget(
                              ctx: context,
                              title: 'Profile Removed',
                              clr: kred);
                        },
                        icon: const Icon(Icons.remove_circle_outline_rounded),
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
                    );
                  }),
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
                  border: Border.all(color: kbackcolor),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 27,
                  color: kbackcolor,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 17, color: kbackcolor),
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
                  border: Border.all(color: kbackcolor),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: const Icon(Icons.playlist_play_rounded,
                    size: 27, color: kbackcolor),
                title: const Text(
                  'Playlist',
                  style: TextStyle(fontSize: 17, color: kbackcolor),
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
                border: Border.all(color: kbackcolor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading:
                    const Icon(Icons.favorite, size: 27, color: kbackcolor),
                title: const Text(
                  'Favourites',
                  style: TextStyle(fontSize: 17, color: kbackcolor),
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
                  border: Border.all(color: kbackcolor),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading:
                    const Icon(Icons.settings, size: 27, color: kbackcolor),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 17, color: kbackcolor),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ));
                },
              ),
            ),
            const Spacer(),
            const Text(
              'Version ',
              style: TextStyle(color: kbackcolor, fontWeight: FontWeight.w500),
            ),
            const Text(
              '1.2v ',
              style: TextStyle(color: kbackcolor, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
