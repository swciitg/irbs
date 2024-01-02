import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';

Future<void> showDialogue(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Themes.darkSlateGrey,
          children: [
            const SizedBox(height: 20,),
            SvgPicture.asset('packages/irbs/assets/rejected.svg',height: 50,),
            const SizedBox(height: 15,),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Request Sent',
                style: MyFonts.w600.size(16).setColor(Themes.white),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        );
      });
}