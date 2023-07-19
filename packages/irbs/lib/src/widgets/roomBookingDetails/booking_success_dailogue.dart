import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../globals/styles.dart';

Future<void> showDialogue(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: const Color.fromRGBO(39, 49, 65, 1),
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
                      color: Colors.white,
                    ),
                  )),
            ),
            Lottie.asset('packages/irbs/assets/sent_request.json',
                height: 100),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Request Sent',
                style: sentRequestStyle,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        );
      });
}