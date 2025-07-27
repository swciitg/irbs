import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';

import '../../globals/styles.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../store/common_store.dart';

class RoomSearchBar extends StatelessWidget {
  const RoomSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Container(
        margin: const EdgeInsets.fromLTRB(
          16,
          29,
          16,
          8,
        ),
        decoration: BoxDecoration(
          color: Themes.darkSlateGrey,
          borderRadius: BorderRadius.circular(4), // Set the radius here
        ),
        width: MediaQuery.of(context).size.width,
        height: 32,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 11),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 16,
              ),
            ),
            SizedBox(
              // height: 20,
              // margin: const EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width - 80,
              child: TextField(
                onChanged: (value) {
                  commonStore.setSearchText(value);
                },
                style: OnestopFonts.w400.size(12).setColor(Themes.white).setHeight(1.333),
                maxLines: 1,
                scrollPhysics: const ClampingScrollPhysics(),
                cursorColor: Themes.comet,
                decoration: searchBarBorder,
              ),
            )
          ],
        ));
  }
}
