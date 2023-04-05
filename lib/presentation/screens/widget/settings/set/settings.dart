import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/presentation/screens/widget/appbar/appbar.dart';
import 'package:musica/presentation/screens/widget/settings/aboutmusica.dart';
import 'package:musica/presentation/screens/widget/settings/termsandcontitions.dart';
import '../privacyandpolicy.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Settings',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(154, 33, 149, 243),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.error_outline,
                    color: kbackcolor,
                  ),
                  title: const Text(
                    'About Audizi',
                    style: TextStyle(
                        color: kbackcolor, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Aboutmus(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(154, 33, 149, 243)),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: const Icon(
                    Icons.build_circle_outlined,
                    color: kbackcolor,
                  ),
                  title: const Text(
                    'Terms And Conditions',
                    style: TextStyle(
                        color: kbackcolor, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Termsandconditions(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(154, 33, 149, 243)),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: const Icon(
                    Icons.gpp_maybe_outlined,
                    color: kbackcolor,
                  ),
                  title: const Text(
                    'Privacy And Policy',
                    style: TextStyle(
                        color: kbackcolor, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Privacyandpolicy(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
