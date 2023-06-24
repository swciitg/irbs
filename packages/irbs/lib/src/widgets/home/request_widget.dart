import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/home/respond_dialog.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            const Padding(
              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 0),
              child: Text(
                'Coding Club Room',
                style: kRequestedRoomStyle,
              ),
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3.35,
              shrinkWrap: true,
              // primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              crossAxisSpacing: 10,
              // mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    'Request by -',
                    style: kHeading3Style,
                  ),
                  subtitle: RichText(
                    text: const TextSpan(
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
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    'Purpose -',
                    style: kHeading3Style,
                  ),
                  subtitle: const Text(
                    'Club meeting',
                    style: kHeading3DescStyle,
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    'Time Slot -',
                    style: kHeading3Style,
                  ),
                  subtitle: RichText(
                    text: const TextSpan(
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
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    'Date -',
                    style: kHeading3Style,
                  ),
                  subtitle: const Text(
                    'April 24, 2023',
                    style: kHeading3DescStyle,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 12),
              child: InkWell(
                child: Container(
                  height: 32,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: const Center(
                    child: Text(
                      'Respond',
                      style: kApproveStyle,
                    ),
                  ),
                ),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return const AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        content: RespondDialog(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
