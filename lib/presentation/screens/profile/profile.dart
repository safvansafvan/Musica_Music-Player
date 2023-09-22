import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/provider/profile_provider/profile_provider.dart';
import 'package:musica/model/profile_model/model/model.dart';
import 'package:musica/presentation/widget/appbar/appbar.dart';
import 'package:musica/presentation/widget/snack_bar.dart';
import 'package:provider/provider.dart';

class Profiewidget extends StatelessWidget {
  const Profiewidget({super.key});
  @override
  Widget build(BuildContext context) {
    // final profilepro = Provider.of<ProfileProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Profile',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
        ),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 40,
                ),
                child: Consumer<ProfileProvider>(builder: (context, value, _) {
                  return Form(
                    key: value.formkey,
                    child: Column(
                      children: [
                        value.photo?.path == null
                            ? Container(
                                height: 180,
                                width: 190,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/profileq.jpeg'),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: blueclr),
                                ),
                              )
                            : Container(
                                height: 180,
                                width: 190,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(value.photo!.path),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: blueclr),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: blueclr),
                                ),
                              ),
                            ),
                            onPressed: () {
                              value.getphoto();
                            },
                            label: const Text('Add Profile'),
                            icon: const Icon(Icons.add),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
                          child: TextFormField(
                            style: const TextStyle(color: kbackcolor),
                            controller: value.namecontroller,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(111, 33, 149, 243),
                                        width: 1.5)),
                                label: const Text(
                                  'Enter Name',
                                  style: TextStyle(color: kbackcolor),
                                ),
                                hintText: 'Name',
                                hintStyle: const TextStyle(color: kbackcolor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: blueclr),
                              ),
                            ),
                          ),
                          onPressed: (() {
                            if (value.photo != null) {
                              Navigator.pop(context);
                              savebuttonclick(context, value);
                            }
                          }),
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Save'),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> savebuttonclick(ctx, ProfileProvider profilepro) async {
    final name = profilepro.namecontroller.text.trim();
    if (name.isEmpty || profilepro.photo!.path.isEmpty) {
      return;
    } else {
      snackBarWidget(ctx: ctx, title: 'Profile Updated', clr: blueclr);
    }
    final userprofile = Profilemodel(
        username: name,
        userimage: profilepro.photo!.path,
        id: DateTime.now().microsecondsSinceEpoch);
    profilepro.adddetails(userprofile);
  }
}
