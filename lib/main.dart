import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musica/controller/provider/allmusic_provider/allmusic_provider.dart';
import 'package:musica/controller/provider/favourite_provider/favourit_provider.dart';
import 'package:musica/controller/provider/mostly_p_provider/mostly_provider.dart';
import 'package:musica/controller/provider/nowplaying_provider/nowplay_provider.dart';
import 'package:musica/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:musica/controller/provider/profile_provider/profile_provider.dart';
import 'package:musica/controller/provider/recently__provider/recently_provider.dart';
import 'package:musica/controller/provider/search_provider/search_provider.dart';
import 'package:musica/controller/provider/splash_provider/splash_provider.dart';
import 'package:musica/controller/provider/provider_nowp_image/songmodelprovider.dart';
import 'package:musica/presentation/screens/splash/splashscreen.dart';
import 'package:provider/provider.dart';
import 'DB/model/model.dart';
import 'DB/profile_model/model/model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ProfilemodelAdapter());
  Hive.registerAdapter(PlayermodelAdapter());

  await Hive.initFlutter();
  await Hive.openBox<int>('favoritesDB');
  await Hive.openBox<Playermodel>('playlistdata');
  await Hive.openBox<Profilemodel>('profiledata');

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllMusicProvider()),
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => FavouriteProvider()),
        ChangeNotifierProvider(create: (context) => RecentlyProvider()),
        ChangeNotifierProvider(create: (context) => MostlyPlayedProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => NowplayingScreenProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        title: 'Audizi Music Player',
        debugShowCheckedModeBanner: false,
        home: const Splashscreemwidgets(),
      ),
    );
  }
}
