import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/presentation/widget/appbar/appbar.dart';

class Aboutmus extends StatelessWidget {
  const Aboutmus({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'About Audizi',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Welcome to Audizi Player App, make your life more live.We are dedicated to providing you the very best quality of sound and the music varient,with an emphasis on new features. playlists and favourites,and a rich user experience\n\nFounded in 2023 by Muhammed Safvan KP . Musica app is our first major project with a basic performance of music hub and creates a better versions in future.Audizi Player gives you the best music experience that you never had. it includes attractivemode of UI\'s and good practices.\n\nIt gives good quality and had increased the settings to power up the system as well as to provide better music rythms.\n\nWe hope you enjoy our music as much as we enjoy offering them to you.If you have any questions or comments, please don\'t hesitate to contact us.\n\nSincerely,\n\nMuhammed Safvan KP',
              style: TextStyle(color: kbackcolor, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
