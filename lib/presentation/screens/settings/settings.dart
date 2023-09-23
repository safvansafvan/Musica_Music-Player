import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/presentation/screens/settings/screens/termsandcontitions.dart';
import 'package:musica/presentation/widget/appbar/appbar.dart';
import 'package:musica/presentation/screens/settings/screens/aboutmusica.dart';
import 'screens/privacyandpolicy.dart';

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
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kbackcolor,
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: kbackcolor),
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
                        builder: (context) => const Termsandcondition(),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: kbackcolor),
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
