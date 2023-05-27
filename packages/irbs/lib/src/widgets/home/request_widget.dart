import 'package:flutter/material.dart';

import '../../globals/styles.dart';
import '../../globals/colors.dart';

class RequestWidget extends StatefulWidget {
  const RequestWidget({Key? key}) : super(key: key);

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Themes.kCommonBoxBackground.withOpacity(0.64),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 0),
              child: Text(
                'Coding Club Room',
                style: kRequestedRoomStyle,
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              shrinkWrap: true,
              // primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              crossAxisSpacing: 10,
              // mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Request by -',
                    style: kHeading3Style,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                        style: kHeading3DescStyle,
                        children: [
                          TextSpan(
                            text: 'Aarya',
                          ),
                          TextSpan(
                            text: ' · ',
                          ),
                          TextSpan(
                            text: 'Design Head',
                          )
                        ]
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Purpose -',
                    style: kHeading3Style,
                  ),
                  subtitle: Text(
                    'Club meeting',
                    style: kHeading3DescStyle,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Time Slot -',
                    style: kHeading3Style,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                        style: kHeading3DescStyle,
                        children: [
                          TextSpan(
                            text: '10:00 AM',
                          ),
                          TextSpan(
                            text: ' - ',
                          ),
                          TextSpan(
                            text: '2:00 PM',
                          )
                        ]
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Date -',
                    style: kHeading3Style,
                  ),
                  subtitle: Text(
                    'April 24, 2023',
                    style: kHeading3DescStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: InkWell(
                    child: Container(
                      height: 24,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(62, 71, 88, 1),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(
                        child: Text(
                          'Reject',
                          style: kRejectStyle,
                        ),
                      ),
                    ),
                    onTap: (){

                    },
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
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(
                        child: Text(
                          'Approve',
                          style: kApproveStyle,
                        ),
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
