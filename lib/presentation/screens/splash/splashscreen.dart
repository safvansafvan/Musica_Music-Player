import 'package:flutter/material.dart';
import 'package:musics/presentation/screens/homeallsongs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigatetohome(ctx) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (context) => const Allsongs(),
      ),
    );
  }

  @override
  void initState() {
    navigatetohome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var meadiaquery = MediaQuery.of(context);

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
            SizedBox(
              height: meadiaquery.size.height * 0.61,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Music Player',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white60),
              ),
            ),
            const Spacer(),
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
