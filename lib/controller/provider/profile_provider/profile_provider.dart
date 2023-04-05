import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musica/DB/profile_model/model/model.dart';

class ProfileProvider with ChangeNotifier {
  ValueListenable<List<Profilemodel>> userprofilelist = ValueNotifier([]);

  Future<void> adddetails(Profilemodel userprofile) async {
    final profile = await Hive.openBox<Profilemodel>('profiledata');
    await profile.add(userprofile);
  }

  Future<void> getdetails() async {
    final profile = await Hive.openBox<Profilemodel>('profiledata');
    userprofilelist.value.clear();
    userprofilelist.value.addAll(profile.values);
    notifyListeners();
  }

  final namecontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  File? photo;
  void getphoto() async {
    final photos = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photos == null) {
      return;
    } else {
      final phototemp = File(photos.path);
      photo = phototemp;
    }
    notifyListeners();
  }
}
