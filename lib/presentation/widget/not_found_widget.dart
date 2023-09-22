import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class NotFoundWidget extends StatelessWidget {
  NotFoundWidget({super.key, required this.isMusicEmptyWid});
  bool isMusicEmptyWid;
  @override
  Widget build(BuildContext context) {
    return isMusicEmptyWid == false
        ? Center(
            child: Lottie.asset("assets/images/msplayer.json"),
          )
        : Center(
            child: Lottie.asset("assets/images/msnotfound.json"),
          );
  }
}
