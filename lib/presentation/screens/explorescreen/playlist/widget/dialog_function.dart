import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:musics/controller/core/core.dart';
import 'package:musics/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:musics/model/model/model.dart';
import 'package:musics/presentation/screens/explorescreen/playlist/playlist.dart';
import 'package:musics/presentation/widget/snack_bar.dart';
import 'package:provider/provider.dart';

final playlistnamecontroller = TextEditingController();

void newplaylist(BuildContext context, formkey) {
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        backgroundColor: dialogcolor,
        children: [
          SimpleDialogOption(
            child: Text(
              'New Playlist',
              style: textStyleFuc(size: 18, clr: white70, bld: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SimpleDialogOption(
            child: Form(
              key: formkey,
              child: TextFormField(
                controller: playlistnamecontroller,
                maxLength: 20,
                decoration: InputDecoration(
                    counterStyle: const TextStyle(color: white70),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: blueclr),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'Playlist Name',
                    labelStyle: const TextStyle(
                      color: white70,
                    ),
                    fillColor: Colors.white70.withOpacity(0.6),
                    filled: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Playlist Name';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    playlistnamecontroller.clear();
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: white70),
                  )),
              TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    okbuttompressing(context);
                  }
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: white70),
                ),
              )
            ],
          ),
        ],
      );
    },
  );
}

// ok buttom click time data add database

Future<void> okbuttompressing(context) async {
  final name = playlistnamecontroller.text.trim();
  final music = Playermodel(name: name, songid: []);
  if (name.isEmpty) {
    return;
  } else {
    Provider.of<PlaylistProvider>(context, listen: false).addplaylist(music);
    snackBarWidget(ctx: context, title: 'Playlist Added', clr: blueclr);
    Navigator.pop(context);
    playlistnamecontroller.clear();
  }
}

// delete playlist show dialog and delete

Future<dynamic> deleteplaylist(
    BuildContext context, Box<Playermodel> musiclist, int index) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      backgroundColor: dialogcolor,
      title: const Text(
        'Delete Playlist',
        style: TextStyle(color: white70),
      ),
      content: const Text(
        'Are You Sure Delete This Playlist ',
        style: TextStyle(color: white70),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: white70),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            musiclist.deleteAt(index);

            snackBarWidget(ctx: context, title: 'Deleted', clr: kred);
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: kred),
          ),
        ),
      ],
    ),
  );
}

// Playlist name edit

TextEditingController namecontroller = TextEditingController();

Future<dynamic> editplaylistname(
    BuildContext context, Playermodel data, int index) {
  namecontroller = TextEditingController(text: data.name);
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      backgroundColor: dialogcolor,
      children: [
        SimpleDialogOption(
          child: Form(
            key: formkey,
            child: Text(
              "Edit Playlist",
              style: textStyleFuc(size: 18, clr: white70, bld: FontWeight.w500),
            ),
          ),
        ),
        SimpleDialogOption(
          child: TextFormField(
            decoration: InputDecoration(
                counterStyle: const TextStyle(color: white70),
                fillColor: Colors.white10.withOpacity(0.4),
                filled: true,
                border: const OutlineInputBorder()),
            controller: namecontroller,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white60),
            textAlign: TextAlign.center,
            maxLength: 20,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                namecontroller.clear();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  final name = namecontroller.text.trim();
                  if (name.isEmpty) {
                    return;
                  } else {
                    final playlistname = Playermodel(name: name, songid: []);
                    Provider.of<PlaylistProvider>(context, listen: false)
                        .editplaylist(playlistname, index);
                  }
                  snackBarWidget(
                      ctx: context,
                      title: 'Playlist Name Changed ',
                      clr: blueclr);

                  Navigator.pop(context);
                }
              },
              child: const Text('OK'),
            )
          ],
        )
      ],
    ),
  );
}
