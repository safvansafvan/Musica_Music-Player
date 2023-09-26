import 'package:flutter/material.dart';
import 'package:musics/controller/core/core.dart';
import 'package:musics/controller/provider/nowplaying_provider/nowplay_provider.dart';
import 'package:provider/provider.dart';

class SongDurationsController extends StatelessWidget {
  const SongDurationsController({
    super.key,
    required this.position,
    required this.duration,
  });

  final Duration position;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Consumer<NowplayingScreenProvider>(
      builder: (context, datas, _) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                position.toString().split('.')[0],
                style: const TextStyle(color: kbackcolor),
              ),
            ),
            Expanded(
                child: Slider(
              min: const Duration(microseconds: 0).inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              onChanged: (value) {
                datas.chagetoseconds(value.toInt());
                value = value;
              },
              activeColor: kbackcolor,
              thumbColor: kbackcolor,
              inactiveColor: kbackcolor,
            )),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                duration.toString().split('.')[0],
                style: const TextStyle(color: kbackcolor),
              ),
            ),
          ],
        );
      },
    );
  }
}
