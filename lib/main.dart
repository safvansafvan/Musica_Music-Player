import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musica/components/splash/splashscreen.dart';
import 'package:musica/provider/songmodelprovider.dart';
import 'package:provider/provider.dart';
import 'DB/Fuctionprofile/model/model.dart';
import 'DB/model/model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(PlayermodelAdapter());
  await Hive.initFlutter();
  await Hive.openBox<int>('favoritesDB');
  await Hive.openBox<Playermodel>('playlistdata');
  await Hive.openBox<Profilemodel>('people');
  

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => Songmodelprovider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
         primarySwatch: Colors.blueGrey,
    
      ),
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      home: const Splashscreemwidget(),
    );
  }
}
