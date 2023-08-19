import 'package:flutter/material.dart';

import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';

class ApprovedDialogue extends StatefulWidget {
  const ApprovedDialogue({Key? key}) : super(key: key);

  @override
  State<ApprovedDialogue> createState() => _ApprovedDialogueState();
}

class _ApprovedDialogueState extends State<ApprovedDialogue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      color: Themes.tileColor,
      width: 227,
      height: 163,
      child: Stack(children: [
        Positioned(
          right: 8,
          top: 8,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.clear,
              color: Themes.white,
              size: 20,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 4, top: 0, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: SizedBox(
                    height: 99,
                    width: 99,
                    // TODO: Insert the GIF
                  ),
                ),
                Text(
                  'Approved',
                  // style: kDialogRoomStyle,
                  style: MyFonts.w600.size(16).setColor(Themes.white).letterSpace(0.5),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
