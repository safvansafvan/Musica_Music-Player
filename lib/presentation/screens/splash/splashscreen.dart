import 'package:flutter/material.dart';
import 'package:musica/controller/provider/splash_provider/splash_provider.dart';
import 'package:provider/provider.dart';

class Splashscreemwidgets extends StatelessWidget {
  const Splashscreemwidgets({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false)
          .navigatetohome(context);
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 39, 33, 55),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/splash2.webp'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 550,
            ),
            Text(
              'Audizi Player',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white60),
            ),
            SizedBox(
              height: 150,
            ),
            Text('Music Is My Life .The Lyrics Are My Story',
                style: TextStyle(fontSize: 10, color: Colors.white60))
          ],
        ),
      ),
    );
  }
}
