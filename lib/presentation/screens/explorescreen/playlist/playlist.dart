import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/DB/model/model.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:musica/presentation/screens/explorescreen/playlist/playlistindividual.dart';
import 'package:musica/presentation/screens/widget/appbar/appbar.dart';
import 'package:musica/presentation/screens/widget/snack_bar.dart';
import 'package:provider/provider.dart';

class Playlistwidget extends StatelessWidget {
  const Playlistwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Playlist',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
        ),
        body: SafeArea(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<Playermodel>('playlistdata').listenable(),
                builder: (BuildContext context, Box<Playermodel> musiclist,
                    Widget? child) {
                  return Hive.box<Playermodel>('playlistdata').isEmpty
                      ? const Center(
                          child: Text(
                            'No Playlist Found',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kbackcolor),
                          ),
                        )
                      : ListView.builder(
                          itemCount: musiclist.length,
                          itemBuilder: (context, index) {
                            final data = musiclist.values.toList()[index];
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      editplaylistname(context, data, index);
                                    },
                                    icon: Icons.edit,
                                    foregroundColor: Colors.blue,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      deleteplaylist(context, musiclist, index);
                                    },
                                    icon: Icons.delete_outline,
                                    foregroundColor: Colors.red,
                                  ),
                                ],
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/images.png')),
                                          color: const Color.fromARGB(
                                              255, 29, 29, 45),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.white30)),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Addplaylist(
                                                        sindex: index,
                                                        playlist: data),
                                              ));
                                        },
                                        leading: const Icon(
                                          Icons.music_note_outlined,
                                          color:
                                              Color.fromARGB(255, 29, 29, 45),
                                        ),
                                        title: Text(
                                          data.name,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 29, 29, 45),
                                          ),
                                        ),
                                        trailing: IconButton(
                                          tooltip: 'Drag Left',
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ))),
                            );
                          },
                        );
                },
              ),
            ),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            newplaylist(context, formkey);
          },
          tooltip: 'Add New Playlist',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
final playlistnamecontroller = TextEditingController();

void newplaylist(BuildContext context, formkey) {
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: Colors.white70,
          children: [
            const SimpleDialogOption(
              child: Text(
                'New Playlist',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 39, 33, 55),
                ),
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
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      labelText: 'Playlist Name',
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 39, 33, 55),
                      ),
                      fillColor: Colors.white70.withOpacity(0.2),
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
            // const  SizedBox(height: 8,),
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
                      style: TextStyle(
                        color: Color.fromARGB(255, 39, 33, 55),
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        okbuttompressing(context);
                      }
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Color.fromARGB(255, 39, 33, 55),
                      ),
                    ))
              ],
            ),
          ]);
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
      backgroundColor: Colors.white60,
      title: const Text(
        'Delete Playlist',
        style: TextStyle(
          color: Color.fromARGB(222, 38, 46, 67),
        ),
      ),
      content: const Text('Are You Sure Delete',
          style: TextStyle(
            color: Color.fromARGB(222, 38, 46, 67),
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color.fromARGB(222, 38, 46, 67),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            musiclist.deleteAt(index);

            snackBarWidget(ctx: context, title: 'Deleted', clr: Colors.red);
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
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
      )),
      backgroundColor: const Color.fromARGB(255, 37, 37, 54),
      children: [
        SimpleDialogOption(
          child: Form(
            key: formkey,
            child: const Text(
              "Edit Playlist",
              style: TextStyle(fontSize: 15, color: Colors.white60),
            ),
          ),
        ),
        SimpleDialogOption(
            child: TextFormField(
          decoration: InputDecoration(
              counterStyle: const TextStyle(color: Colors.white10),
              fillColor: Colors.white10.withOpacity(0.2),
              filled: true,
              border: const OutlineInputBorder()),
          controller: namecontroller,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white60),
          textAlign: TextAlign.center,
          maxLength: 20,
        )),
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
