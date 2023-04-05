import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musica/controller/core/core.dart';
import 'package:musica/controller/provider/search_provider/search_provider.dart';
import 'package:musica/presentation/screens/allmusic/allmusiclisttile.dart';
import 'package:musica/presentation/screens/widget/appbar/appbar.dart';

import 'package:provider/provider.dart';

class Searchwidget extends StatelessWidget {
  const Searchwidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final seachProvid = Provider.of<SearchProvider>(context, listen: false);
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
          return Column(
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
                  ? const Padding(
                      padding: EdgeInsets.only(top: 270),
                      child: Center(
                        child: Text(
                          'No Songs ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kbackcolor),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Allmusiclisttile(
                        songmodel: data.stillsongs,
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
