import 'package:flutter/material.dart';
import 'package:musica/presentation/screens/homeallsongs.dart';

class SplashProvider extends ChangeNotifier {
  void navigatetohome(ctx) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (context) => const Allsongs(),
      ),
    );
    notifyListeners();
  }
}
