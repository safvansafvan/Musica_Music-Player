import 'package:flutter/material.dart';


class Mostplayed extends StatefulWidget {
  const Mostplayed({super.key});

  @override
  State<Mostplayed> createState() => _MostplayedState();
}

class _MostplayedState extends State<Mostplayed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
        return const ListTile(
          leading: Icon(Icons.music_note),
          title: Text('Music name'),
        );
      },),
    );
  }
}