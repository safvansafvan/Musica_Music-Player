import 'package:flutter/material.dart';
import 'package:musica/controller/provider/splash_provider/splash_provider.dart';
import 'package:provider/provider.dart';

class Splashscreemwidgets extends StatelessWidget {
  const Splashscreemwidgets({super.key});

  @override
  Widget build(BuildContext context) {
    var meadiaquery = MediaQuery.of(context);
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
            image: AssetImage('assets/images/newsplash.jpg'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 30),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ic_launcher.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: meadiaquery.size.height * 0.61,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Audizi Player',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white60),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Music Is My Life .The Lyrics Are My Story',
                style: TextStyle(fontSize: 10, color: Colors.white60),
              ),
            )
          ],
        ),
      ),
    );
  }
}
