import 'package:flutter/material.dart';
import '../../globals/styles.dart';

import '../../globals/colors.dart';

class UpcomingBookingsWidget extends StatefulWidget {
  final int status;
  final String startTime;
  final String endTime;
  final String date;
  final String name;
  const UpcomingBookingsWidget(
      {Key? key,
      required this.status,
      required this.startTime,
      required this.endTime,
      required this.date,
      required this.name})
      : super(key: key);

  @override
  State<UpcomingBookingsWidget> createState() => _UpcomingBookingsWidgetState();
}

class _UpcomingBookingsWidgetState extends State<UpcomingBookingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(stops: [
              0.0125,
              0.0125
            ], colors: [
              (widget.status == 0)
                  ? Color.fromRGBO(217, 114, 108, 1)
                  : (widget.status == 1)
                      ? Color.fromRGBO(147, 144, 148, 1)
                      : Color.fromRGBO(53, 118, 42, 1),
              Themes.kCommonBoxBackground
            ]),
            borderRadius: BorderRadius.circular(4)),
        child: ListTile(
          tileColor: Themes.kCommonBoxBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            style: kRequestedRoomStyle,
          ),
          subtitle: RichText(
            text: TextSpan(style: kHeading3DescStyle, children: [
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
            ]),
          ),
          trailing: InkWell(
            onTap: () {},
            child: Container(
              width: 88,
              height: 24,
              child: Center(
                child: Text(
                  (widget.status == 0)
                      ? 'Rejected'
                      : (widget.status == 1)
                          ? 'Pending'
                          : 'Approved',
                  style: (widget.status == 0)
                      ? rejectTextStyle
                      : (widget.status == 1)
                          ? pendingStyle
                          : approvedStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
