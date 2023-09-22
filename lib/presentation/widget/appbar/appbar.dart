import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/presentation/screens/search/search.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      {super.key,
      required this.titles,
      required this.leading,
      required this.trailing,
      required this.search,
      required this.menu});

  final String titles;
  final IconData leading;
  final IconData trailing;

  bool search = false;
  bool menu = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBodyColor,
      child: ListTile(
        leading: menu
            ? IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(leading))
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(leading),
              ),
        title: Text(
          titles,
          style: textStyleFuc(size: 18, clr: kbackcolor, bld: FontWeight.w500),
        ),
        trailing: search
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Searchwidget();
                      },
                    ),
                  );
                },
                icon: Icon(trailing),
              )
            : IconButton(
                onPressed: () {},
                icon: Icon(trailing),
              ),
      ),
    );
  }
}
