import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';

import 'approved_dialog.dart';

class RespondDialog extends StatefulWidget {
  const RespondDialog({Key? key}) : super(key: key);

  @override
  State<RespondDialog> createState() => _RespondDialogState();
}

class _RespondDialogState extends State<RespondDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      color: Themes.kCommonBoxBackground,
      width: double.maxFinite,
      height: 280,
      child: Stack(children: [
        Positioned(
          right: 16,
          top: 16,
          child: GestureDetector(
            // constraints: BoxConstraints(),
            // padding: EdgeInsets.zero,
            // iconSize: 20,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.clear,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 12),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: 'Requested by  ', style: kHeading3Style),
                      TextSpan(style: kHeading3DescStyle, children: [
                        TextSpan(
                          text: 'Aarya',
                        ),
                        TextSpan(
                          text: ' · ',
                        ),
                        TextSpan(
                          text: 'Design Head',
                        )
                      ]),
                    ]),
                  ),
                ),
                RichText(
                    maxLines: 1,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Exibition Hall',
                        style: kDialogRoomStyle,
                      ),
                      TextSpan(text: '  ', style: kDialogRoomStyle),
                      TextSpan(text: 'Common Room', style: kDialogSubRoomStyle)
                    ])),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 5,
                  shrinkWrap: true,
                  // primary: false,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7.33),
                          child: Icon(
                            Icons.access_time,
                            color: Color.fromRGBO(162, 172, 192, 1),
                            size: 13.33,
                          ),
                        ),
                        RichText(
                          text: TextSpan(style: kDialogTimeStyle, children: [
                            TextSpan(
                              text: '10:00 AM',
                            ),
                            TextSpan(
                              text: ' - ',
                            ),
                            TextSpan(
                              text: '2:00 PM',
                            )
                          ]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7.33),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Color.fromRGBO(162, 172, 192, 1),
                            size: 13.33,
                          ),
                        ),
                        Text(
                          'Apr 24, 2023',
                          style: kDialogTimeStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Purpose - ', style: kDialogPurposeStyle),
                    TextSpan(text: 'Club Meeting', style: kDialogTimeStyle)
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 8, left: 0, right: 0),
                  child: Text(
                    'Instruction/Reason to reject -',
                    style: kDialogInstStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, top: 0, bottom: 0),
                  child: SizedBox(
                    height: 64,
                    width: double.maxFinite,
                    child: TextField(
                      maxLines: 3,
                      style: editRoomText,
                      decoration: InputDecoration(
                        hintText: 'Type Here...',
                        hintStyle: kDialogHintStyle,
                        // contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.white.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(4)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.white.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.75,
                  shrinkWrap: true,
                  // primary: false,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InkWell(
                        child: Container(
                          height: 24,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(62, 71, 88, 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              'Reject',
                              style:
                                  kRejectedStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InkWell(
                        child: Container(
                          height: 24,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(118, 172, 255, 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              'Approve',
                              style: kApproveStyle,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: ApprovedDialog(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
