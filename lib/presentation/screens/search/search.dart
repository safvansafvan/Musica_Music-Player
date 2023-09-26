import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musics/controller/core/core.dart';
import 'package:musics/controller/provider/search_provider/search_provider.dart';
import 'package:musics/presentation/screens/allmusic/widget/allmusiclisttile.dart';
import 'package:musics/presentation/widget/appbar/appbar.dart';
import 'package:musics/presentation/widget/not_found_widget.dart';
import 'package:provider/provider.dart';

class Searchwidget extends StatelessWidget {
  const Searchwidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchProvider>(context, listen: false).fetchallsongs();
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBodyColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: AppBarWidget(
              titles: 'Search',
              leading: Icons.arrow_back_ios,
              trailing: Icons.more_vert,
              search: false,
              menu: false),
        ),
        body: Consumer<SearchProvider>(builder: (context, data, _) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CupertinoSearchTextField(
                  onChanged: (value) => data.textupdatetextfield(value),
                  padding: const EdgeInsets.all(12),
                  style: textStyleFuc(
                      size: 15, clr: Colors.grey, bld: FontWeight.w500),
                ),
              ),
              data.stillsongs.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NotFoundWidget(isMusicEmptyWid: true),
                      ],
                    )
                  : Allmusiclisttile(
                      songmodel: data.stillsongs,
                    ),
            ],
          );
        }),
      ),
    );
  }
}
