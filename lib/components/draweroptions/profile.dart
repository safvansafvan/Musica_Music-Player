import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musica/DB/Fuctionprofile/func.dart';
import 'package:musica/DB/Fuctionprofile/model/model.dart';

class Profiewidget extends StatefulWidget {
  const Profiewidget({super.key});

  @override
  State<Profiewidget> createState() => _ProfiewidgetState();
}

class _ProfiewidgetState extends State<Profiewidget> {
  final namecontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 42, 35, 58),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 42, 35, 58),
          elevation: 15,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'Profile',
            style: TextStyle(fontSize: 20, color: Colors.white60),
          ),
        ),
        body: SafeArea(
            child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 40,
            ),
            child: Column(
              children: [
                photo?.path == null
                    ? Container(
                        height: 150,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/images/profileq.jpeg')),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(111, 33, 149, 243))),
                      )
                    : Container(
                        height: 150,
                        width: 180,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(photo!.path))),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(111, 33, 149, 243))),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        getphoto();
                      },
                      child: const Text('Add Profile')),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white60),
                    controller: namecontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(111, 33, 149, 243),
                                width: 1.5)),
                        label: const Text(
                          'Enter Name',
                          style: TextStyle(color: Colors.white60),
                        ),
                        hintText: 'Name',
                        hintStyle: const TextStyle(color: Colors.white60),
                        border: OutlineInputBorder(
                          //  borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                ElevatedButton.icon(
                    onPressed: (() {
                      if (photo != null) {
                        Navigator.pop(context);
                        savebuttonclick();
                        
                      }
                    }),
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Save'))
              ],
            ),
          )
        ])));
  }

  Future<void> savebuttonclick() async {
    final name = namecontroller.text.trim();
    if (name.isEmpty || photo!.path.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
       
          backgroundColor: Color.fromARGB(222, 38, 46, 67),
          behavior: SnackBarBehavior.floating,
          
          content: Text(
            'Profile Updated',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          )));
    }
    final userprofile = Profilemodel(username: name, userimage: photo!.path);
    // print(userprofile.username);
    adddetails(userprofile);
  }

  File? photo;
  void getphoto() async {
    final photos = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photos == null) {
      return;
    } else {
      final phototemp = File(photos.path);
      setState(() {
        photo = phototemp;
      });
    }
  }
}
