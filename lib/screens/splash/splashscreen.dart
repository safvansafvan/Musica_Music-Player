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
            decoration: const BoxDecoration(
              color:Color.fromARGB(255, 39, 33, 55),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/splash2.webp'))
            ),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             children:const [
              SizedBox(height: 550,),
              // Icon(Icons.music_note,size: 150,color: Colors.white54,),
              Text('Audizi Player',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color:Colors.white60),),
              SizedBox(height: 150,),
              Text('Music Is My Life .The Lyrics Are My Story',style: TextStyle(fontSize: 10,color:Colors.white60))
             ],
            ),
          ),
    );
  }
}