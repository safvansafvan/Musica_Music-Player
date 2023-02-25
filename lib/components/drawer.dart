import 'package:flutter/material.dart';
import 'package:musica/components/draweroptions/profile.dart';
import 'package:musica/explorescreen/favourites/favorites.dart';

class Drawerwidget extends StatefulWidget {
  const Drawerwidget({super.key});

  @override
  State<Drawerwidget> createState() => _DrawerwidgetState();
}

class _DrawerwidgetState extends State<Drawerwidget> {
//  final data= getprofile();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListTile(
          leading: const CircleAvatar(
              radius: 33,
              child: Icon(
                Icons.person,
                color: Colors.white70,
              )),
             
          title:const Text('',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white70),
          ),
          subtitle: const Text(
            'Musica player',
            style: TextStyle(color: Colors.white70),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const Profiewidget();
              },
            ));
          },
        ),
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
      // const SizedBox(
      //   height: 5,
      // ),
      // Container(
      //    width:285,
      //   decoration: BoxDecoration(
      //       color: Colors.blue[200], borderRadius: BorderRadius.circular(15)),
      //   child: const ListTile(
      //     leading: Icon(
      //       Icons.language,
      //       size: 27,
      //       color: Colors.white,
      //     ),
      //     title: Text(
      //       'Language',
      //       style: TextStyle(fontSize: 17, color: Colors.white),
      //     ),
      //   ),
      // ),
      const SizedBox(
        height: 5,
      ),
      Container(
        width: 285,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/contact.jpg')),
            color: Colors.blue[200],
            border: Border.all(color: Colors.white60),
            borderRadius: BorderRadius.circular(15)),
        child: const ListTile(
          leading: Icon(
            Icons.contact_page,
            size: 27,
            color: Colors.white,
          ),
          title: Text(
            'Contact us',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
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
        child: const ListTile(
          leading: Icon(
            Icons.settings,
            size: 27,
            color: Colors.white,
          ),
          title: Text(
            'Settings',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      ),
      const SizedBox(
        height: 350,
      ),
      const Text(
        'Version ',
        style: TextStyle(color: Colors.white70),
      ),
      const Text(
        '1.0v ',
        style: TextStyle(color: Colors.white70),
      )
    ]));
  }
}
