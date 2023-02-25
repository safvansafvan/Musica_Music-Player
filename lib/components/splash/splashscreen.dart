import 'package:flutter/material.dart';
import 'package:musica/screens/homeallsongs.dart';


class Splashscreemwidget extends StatefulWidget {
  const Splashscreemwidget({super.key});

  @override
  State<Splashscreemwidget> createState() => _SplashscreemwidgetState();
}

class _SplashscreemwidgetState extends State<Splashscreemwidget> {
   
   @override
  void initState() {
    super.initState();
    navigatetohome();
    
  }
  void navigatetohome()async{
    await Future.delayed(const Duration(milliseconds: 1500),(){});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const Allsongs(), ));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body:Container(
            width:double.infinity,
            color:const Color.fromARGB(255, 39, 33, 55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             children:const [
              Icon(Icons.music_note,size: 150,color: Colors.white54,),
              Text('Musica',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white54,),)
             ],
            ),
          ),
    );
  }
}