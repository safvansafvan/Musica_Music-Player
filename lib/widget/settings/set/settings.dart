import 'package:flutter/material.dart';
import 'package:musica/widget/settings/termsandcontitions.dart';

import '../aboutmusica.dart';
import '../privacyandpolicy.dart';

class Settigs extends StatelessWidget {
  const Settigs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 33, 55),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 33, 55),
        elevation: 15,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back_ios,
          color: Colors.white60,)) ,
        title: const Text(
          'Settings',
          style: TextStyle(
              color: Colors.white60, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(154, 33, 149, 243)),
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading:const Icon(
                  Icons.error_outline,
                  color: Colors.white60,
                ),
                title:const Text(
                  'About Musica',
                  style: TextStyle(
                      color: Colors.white60, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const Aboutmus(),));
                },
              ),
            ),
           const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color:const Color.fromARGB(154, 33, 149, 243)),
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading:const Icon(
                  Icons.build_circle_outlined,
                  color: Colors.white60,
                ),
                title:const Text(
                  'Terms And Conditions',
                  style: TextStyle(
                      color: Colors.white60, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const Termsandconditions(),));
                },
              ),
            ),
           const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color:const Color.fromARGB(154, 33, 149, 243)),
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading:const Icon(
                  Icons.gpp_maybe_outlined,
                  color: Colors.white60,
                ),
                title:const Text(
                  'Privacy And Policy',
                  style: TextStyle(
                      color: Colors.white60, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const Privacyandpolicy(),));
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
