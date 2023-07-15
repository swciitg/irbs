import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/widgets/booking_end_delete_dailogue.dart';
import '../../functions/snackbar.dart';
import '../../globals/styles.dart';

import '../../globals/colors.dart';
import '../../models/booking_model.dart';

class CurrentBookingsWidget extends StatefulWidget {
  final BookingModel model;
  final refreshHome;
  const CurrentBookingsWidget(
      {Key? key, required this.model, this.refreshHome,
      })
      : super(key: key);

  @override
  State<CurrentBookingsWidget> createState() => _CurrentBookingsWidgetState();
}

class _CurrentBookingsWidgetState extends State<CurrentBookingsWidget> {
  Offset _tapPosition = Offset.zero;

  int isUpcoming()
  {
      DateTime d = DateTime.now();
      DateTime dt1 = DateTime.parse( DateTime(d.year, d.month, d.day,d.hour,d.minute).toIso8601String()+"Z");
      DateTime dt2 = DateTime.parse(widget.model.inTime);
      DateTime dt3 = DateTime.parse(widget.model.outTime);

      if(dt1.compareTo(dt3) > 0){
        print("Booking period is over");
        return 0;
      }
      if(dt1.compareTo(dt2) < 0){
        print("Booking period aint started");
        return 1;
      }
      print("Booking period is active");
      return 2;
  }

  @override
  Widget build(BuildContext context) {
    isUpcoming();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(stops: [
              0.0125,
              0.0125
            ], colors: [
              widget.model.status == "rejected"
                  ? Color.fromRGBO(179, 38, 30, 1)
                  : widget.model.status == "accepted"
                      ? Color.fromRGBO(83, 172, 75, 1)
                      : Color.fromRGBO(147, 144, 148, 1),
              Themes.kCommonBoxBackground
            ]),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            ListTile(
              tileColor: Themes.kCommonBoxBackground,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              title: Text(
                widget.model.roomDetails.roomName,
                style: kRequestedRoomStyle,
              ),
              subtitle: RichText(
                text: TextSpan(style: kHeading3DescStyle, children: [
                  TextSpan(
                    text: DateFormat("hh:mm a")
                        .format(DateTime.parse(widget.model.inTime)),
                  ),
                  TextSpan(
                    text: ' - ',
                  ),
                  TextSpan(
                    text: DateFormat("hh:mm a")
                        .format(DateTime.parse(widget.model.outTime)),
                  ),
                  TextSpan(
                    text: ' · ',
                  ),
                  TextSpan(
                    text: DateFormat("dd MMMM")
                        .format(DateTime.parse(widget.model.inTime))
                  )
                ]),
              ),
              trailing: Container(
                width: 88,
                height: 24,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.model.status == 'rejected'
                            ? 'Rejected'
                            : widget.model.status == 'accepted'
                                ? 'Approved'
                                : 'Pending',
                        style: widget.model.status == 'rejected'
                            ? kRejectedStyle
                            : widget.model.status == 'accepted'
                                ? kApprovedStyle
                                : kPendingStyle,
                      ),
                      widget.model.status == 'rejected' || (widget.model.status == 'accepted' && (isUpcoming() == 0))
                          ? Container()
                          : InkWell(
                              onTapDown: (TapDownDetails tapDownDetails) {
                                _tapPosition = tapDownDetails.globalPosition;
                              },
                              onTap: () async {
                                final RenderBox overlay = Overlay.of(context)
                                    .context
                                    .findRenderObject() as RenderBox;

                                final result = await showMenu(
                                    color: Color.fromRGBO(39, 49, 65, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    context: context,
                                    position: RelativeRect.fromSize(
                                        _tapPosition & const Size(0, 0),
                                        overlay.size),
                                    items: [
                                      widget.model.status == 'requested' || isUpcoming() == 1
                                          ? PopupMenuItem(
                                              value: "delete",
                                              child: Text(
                                                "Delete booking",
                                                style: popupMenuStyle,
                                              ))
                                          :
                                      PopupMenuItem(
                                              value: "end",
                                              child: Text(
                                                "End Booking",
                                                style: popupMenuStyle,
                                              ))
                                    ]);
                                switch (result) {
                                  case "delete":
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return BookingDailogueBox(bookingId: widget.model.id, purpose: "delete");
                                        });
                                    print("delete");
                                    break;
                                  case "end":
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return BookingDailogueBox(bookingId: widget.model.id, purpose: "end");
                                        });
                                    print("end");
                                    break;
                                  default:
                                    print("nothing");
                                    break;
                                }
                              },
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            widget.model.acceptInstructions == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 0, bottom: 12),
                    child: Container(
                      // padding: EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 12),
                      child: InputDecorator(
                        decoration: InputDecoration(
                            // contentPadding: EdgeInsets.zero,
                            labelText:
                                widget.model.status == 'rejected' ? 'Reason' : 'Instructions',
                            labelStyle: kLabelStyle,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.56,
                                    color: Color.fromRGBO(85, 95, 113, 1)),
                                borderRadius: BorderRadius.circular(4.46))),
                        child: Text(
                          widget.model.acceptInstructions ?? '',
                          style: kReasonStyle,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
