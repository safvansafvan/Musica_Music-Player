import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/DB/Functions/functionplaylist.dart';
import 'package:musica/DB/model/model.dart';
import 'package:musica/explorescreen/playlist/playlistindividual.dart';

class Playlistwidget extends StatefulWidget {
  const Playlistwidget({super.key});

  @override
  State<Playlistwidget> createState() => _PlaylistwidgetState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
final playlistnamecontroller = TextEditingController();

class _PlaylistwidgetState extends State<Playlistwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 37, 54),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 37, 54),
        elevation: 15,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white60,
            )),
        title: const Text(
          'Playlist',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white60),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Playermodel>('playlistdata').listenable(),
                  builder: (BuildContext context, Box<Playermodel> musiclist,
                      Widget? child) {
                    return ListView.builder(
                      itemCount: musiclist.length,
                      itemBuilder: (context, index) {
                        final data = musiclist.values.toList()[index];
                        return Slidable(
                          endActionPane:
                              ActionPane(motion: const BehindMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
                                deleteplaylist(context, musiclist, index);
                              },
                              
                              icon: Icons.delete_outline,
                              foregroundColor: Colors.red,
                              backgroundColor: const Color.fromARGB(255, 37, 37, 54),
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                editplaylistname(context, data, index);
                              },
                              icon: Icons.edit,
                              backgroundColor: const Color.fromARGB(255, 37, 37, 54),
                            ),
                            
                          ]),
                          child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/playlistss.png')),
                                      color: const Color.fromARGB(255, 29, 29, 45),
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Colors.white30)),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Playlisttoaddsong(
                                                    sindex: index,
                                                    playlist: data),
                                          ));
                                    },
                                    leading: const Icon(
                                      Icons.music_note_outlined,
                                      color: Color.fromARGB(255, 29, 29, 45),
                                    ),
                                    title: Text(
                                      data.name,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 29, 29, 45),
                                      ),
                                    ),
                                    trailing: IconButton( tooltip: 'Drag Left', icon: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,), onPressed: () { 
                                      
                                     },),
                                    // trailing: PopupMenuButton(
                                    //   color: Colors.white60,
                                    //   icon: const Icon(Icons.more_vert),
                                    //   itemBuilder: (context) {
                                    //     return [
                                    //       PopupMenuItem(
                                    //           value: 1,
                                    //           child: Row(
                                    //             children: const [
                                    //               Icon(
                                    //                 Icons.delete_outlined,
                                    //                 color: Color.fromARGB(
                                    //                     255, 39, 33, 55),
                                    //               ),
                                    //               Text(
                                    //                 'Delete',
                                    //                 style: TextStyle(
                                    //                   color: Color.fromARGB(
                                    //                       255, 39, 33, 55),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           )),
                                    //       PopupMenuItem(
                                    //           value: 2,
                                    //           child: Row(
                                    //             children: const [
                                    //               Icon(
                                    //                 Icons.edit,
                                    //                 color: Color.fromARGB(
                                    //                     255, 39, 33, 55),
                                    //               ),
                                    //               Text('Edit',
                                    //                   style: TextStyle(
                                    //                     color: Color.fromARGB(
                                    //                         255, 39, 33, 55),
                                    //                   )),
                                    //             ],
                                    //           )),
                                    //     ];
                                    //   },
                                    //   onSelected: (value) {
                                    //     if (value == 1) {
                                    //       deleteplaylist(
                                    //           context, musiclist, index);
                                    //     } else if (value == 2) {
                                    //       editplaylistname(
                                    //           context, data, index);
                                    //     }
                                    //   },
                                    // )
                                  ))),
                        );
                      },
                    );
                  },
                ),
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newplaylist(context, formkey);
        },
        tooltip: 'Add New Playlist',
        child:const  Icon(Icons.add),
      ),
    );
  }

  //function
//show dialog in create playlist
}

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
                  maxLength: 10,
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
                        //
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
    Playlistdatabase.addplaylist(music);
    const addplaylistsnak = SnackBar(
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        duration: Duration(seconds: 1),
        content: Center(
            child: Text('Playlist Added',
                style: TextStyle(color: Colors.white60))));
    ScaffoldMessenger.of(context).showSnackBar(addplaylistsnak);
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
            child: const Text('Cancel',
                style: TextStyle(
                  color: Color.fromARGB(222, 38, 46, 67),
                ))),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              musiclist.deleteAt(index);
              const deletesnake = SnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.red,
                  content: Center(
                      child: Text('Playlist Deleted',
                          style: TextStyle(color: Colors.white60))));
              ScaffoldMessenger.of(context).showSnackBar(deletesnake);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)))
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
          maxLength: 10,
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
                    Playlistdatabase.editplaylist(playlistname, index);
                    // final playlistName = Playermodel(name: name, songId: []);
                    // PlaylistDb.editList(index, playlistName);
                  }

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
