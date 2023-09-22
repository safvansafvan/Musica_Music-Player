import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/model/model/model.dart';
import 'package:musica/presentation/screens/explorescreen/playlist/widget/dialog_function.dart';
import 'package:musica/presentation/screens/explorescreen/playlist/widget/song_list_screen.dart';
import 'package:musica/presentation/widget/appbar/appbar.dart';
import 'package:musica/presentation/widget/not_found_widget.dart';

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
        body: Center(
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
                      ? NotFoundWidget(isMusicEmptyWid: false)
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
                                    icon: Icons.delete_outline_rounded,
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
                                          'assets/images/images.png'),
                                    ),
                                    color:
                                        const Color.fromARGB(255, 29, 29, 45),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: blueclr),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SongListScreen(
                                                    sindex: index,
                                                    playlist: data),
                                          ));
                                    },
                                    leading: const Icon(
                                      Icons.music_note_outlined,
                                      color: Color.fromARGB(255, 29, 29, 45),
                                    ),
                                    title: Text(
                                      data.name.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: kwhite),
                                    ),
                                    trailing: IconButton(
                                      tooltip: 'Drag Left',
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.blue)),
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
