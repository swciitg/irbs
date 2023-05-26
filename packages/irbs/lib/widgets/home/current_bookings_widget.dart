import 'package:flutter/material.dart';
import '../../src/globals/styles.dart';

import '../../src/globals/colors.dart';

class CurrentBookingsWidget extends StatefulWidget {
  final bool cancelled;
  final String startTime;
  final String endTime;
  final String date;
  final String roomName;
  const CurrentBookingsWidget({Key? key, required this.cancelled, required this.startTime, required this.endTime, required this.date, required this.roomName}) : super(key: key);

  @override
  State<CurrentBookingsWidget> createState() => _CurrentBookingsWidgetState();
}

class _CurrentBookingsWidgetState extends State<CurrentBookingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.0125, 0.0125],
                colors: [widget.cancelled ? Color.fromRGBO(179, 38, 30, 1) : Color.fromRGBO(147, 144, 148, 1), Themes.kCommonBoxBackground]
            ),
            borderRadius: BorderRadius.circular(4)),
        child: ListTile(
          tileColor: Themes.kCommonBoxBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          ),
          title: Text(
            widget.roomName,
            style: kRequestedRoomStyle,
          ),
          subtitle: RichText(
            text: TextSpan(
                style: kHeading3DescStyle,
                children: [
                  TextSpan(
                    text: widget.startTime,
                  ),
                  TextSpan(
                    text: ' - ',
                  ),
                  TextSpan(
                    text: widget.endTime,
                  ),
                  TextSpan(
                    text: ' · ',
                  ),
                  TextSpan(
                    text: widget.date,
                  )
                ]
            ),
          ),
          trailing: InkWell(
            onTap: (){

            },
            child: Container(
              width: 88,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                color: widget.cancelled ? Color.fromRGBO(179, 38, 30, 1) : Color.fromRGBO(147, 144, 148, 1),
              ),
              child: Center(
                child: Text(
                  widget.cancelled ? 'Cancelled' : 'Pending',
                  style: kRejectStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
