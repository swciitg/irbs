import 'package:flutter/material.dart';
import 'package:irbs/src/globals/my_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../globals/colors.dart';

Future<void> showDialogue(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Themes.darkSlateGrey,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.close,
                      color: Themes.white,
                    ),
                  )),
            ),
            Lottie.asset('packages/irbs/assets/sent_request.json',
                height: 100),
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