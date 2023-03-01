
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:musica/DB/Fuctionprofile/model/model.dart';
//  class profile{
//   static ValueNotifier  profilnotifer =ValueNotifier([]);
//  static final  profileDB=Hive.box<Profilemodel>('profiledetils');

// static Future<void>  adddetails(Profilemodel value)async{
//  final profileDB=await Hive.openBox<Profilemodel>('profiledetils');
//  await  profileDB.add(value);
//   profilnotifer.value.add(value);
//  profilnotifer.notifyListeners();
// }
// Future<void> getdetails()async{
//   final profileDB=await Hive.openBox<Profilemodel>('profiledetils');
//   profilnotifer.value.clear();
//   profilnotifer.value.addAll(profileDB.values);
//   profilnotifer.notifyListeners();

// }
// Future<void>editdetails(int index,Profilemodel value)async{
//    final profileDB=await Hive.openBox<Profilemodel>('profiledetils');
//    profileDB.putAt(index, value);
//    getdetails();
// }

// }
