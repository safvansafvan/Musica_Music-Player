

import 'package:flutter/material.dart';

class Songmodelprovider with ChangeNotifier   {
  int idd=0;
  int get id => idd;


  void setid(int id){
       idd=id;
       notifyListeners();
  }
  
}