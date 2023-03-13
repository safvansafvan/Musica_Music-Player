import 'package:flutter/material.dart';

class Aboutmus extends StatelessWidget {
  const Aboutmus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 33, 55),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 33, 55),
          elevation: 15,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'About Audizi',
            style: TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ),
        body: const SafeArea(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Welcome to Audizi Player App, make your life more live.We are dedicated to providing you the very best quality of sound and the music varient,with an emphasis on new features. playlists and favourites,and a rich user experience\n\nFounded in 2023 by Muhammed Safvan KP . Musica app is our first major project with a basic performance of music hub and creates a better versions in future.Audizi Player gives you the best music experience that you never had. it includes attractivemode of UI\'s and good practices.\n\nIt gives good quality and had increased the settings to power up the system as well as to provide better music rythms.\n\nWe hope you enjoy our music as much as we enjoy offering them to you.If you have any questions or comments, please don\'t hesitate to contact us.\n\nSincerely,\n\nMuhammed Safvan KP',
                style: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w400),
              )),
        ));
  }
}
