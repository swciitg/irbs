import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';

class ApprovedDialog extends StatefulWidget {
  const ApprovedDialog({Key? key}) : super(key: key);

  @override
  State<ApprovedDialog> createState() => _ApprovedDialogState();
}

class _ApprovedDialogState extends State<ApprovedDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      color: Themes.kCommonBoxBackground,
      width: 227,
      height: 163,
      child: Stack(
          children: [
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                // constraints: BoxConstraints(),
                // padding: EdgeInsets.zero,
                // iconSize: 20,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Container(
                        height: 99,
                        width: 99,
                        // TODO: Insert the GIF
                      ),
                    ),
                    Text(
                      'Approved',
                      style: kDialogRoomStyle,
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
}
