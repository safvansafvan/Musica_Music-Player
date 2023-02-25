import 'package:flutter/material.dart';

Future<void>delete(BuildContext context)async{
    showDialog(context:context , builder: (context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text('The selected song will be deleted in storage'),
        actions: [
          Wrap(
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child:const Text('Cancel') ),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child:const Text('Delete',style:TextStyle(color: Colors.red),) )
            ],
          )
        ],
      );
    },);
}