import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';

class BookingTile extends StatefulWidget {
  final int status;
  final String startTime;
  final String roomName;
  final String endTime;
  final String date;
  final bool current;
  const BookingTile(
      {Key? key,
      required this.startTime,
      required this.roomName,
      required this.endTime,
      required this.date,
      required this.current,
      required this.status})
      : super(key: key);

  @override
  State<BookingTile> createState() => _BookingTileState();
}

class _BookingTileState extends State<BookingTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: widget.current ? const [0.0125, 0.0125] : const [0, 0],
                colors: [
                  widget.status == 0
                      ? Themes.rejectedColor
                      : widget.status == 1
                          ? Themes.approvedGreenColor
                          : Themes.pendingColor,
                  Themes.kCommonBoxBackground
                ]),
            borderRadius: BorderRadius.circular(4)),
        child: ListTile(
          tileColor: Themes.kCommonBoxBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: Text(
            widget.roomName,
            style: kRequestedRoomStyle,
          ),
          subtitle: RichText(
            text: TextSpan(style: kHeading3DescStyle, children: [
              TextSpan(
                text: widget.startTime,
              ),
              const TextSpan(
                text: ' - ',
              ),
              TextSpan(
                text: widget.endTime,
              ),
              const TextSpan(
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
              ),
              child: Center(
                child: Text(
                  widget.status == 0
                      ? 'Rejected'
                      : widget.status == 1
                          ? 'Approved'
                          : 'Pending',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    package: 'irbs',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    color: widget.status == 0
                        ? Themes.rejectedColor
                        : widget.status == 1
                            ? Themes.approvedGreenColor
                            : Themes.pendingColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
