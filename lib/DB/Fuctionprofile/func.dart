import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'model/model.dart';

ValueNotifier <List<Profilemodel>>profilenotifier=ValueNotifier([]);

Future<void> adddetails(Profilemodel userprofile) async {
  final profile = await Hive.openBox<Profilemodel>('profiledata');
  profile.add(userprofile);
  profilenotifier.value.add(userprofile);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  profilenotifier.notifyListeners();
}

Future<void>getdetails()async{
   final profile = await Hive.openBox<Profilemodel>('profiledata');
   profilenotifier.value.clear();
   profilenotifier.value.addAll(profile.values);
   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
   profilenotifier.notifyListeners();
}

