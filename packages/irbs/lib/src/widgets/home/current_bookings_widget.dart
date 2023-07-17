import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:provider/provider.dart';
import '../../globals/styles.dart';
import '../../globals/colors.dart';
import '../../models/booking_model.dart';

class CurrentBookingsWidget extends StatefulWidget {
  final BookingModel model;
  const CurrentBookingsWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<CurrentBookingsWidget> createState() => _CurrentBookingsWidgetState();
}

class _CurrentBookingsWidgetState extends State<CurrentBookingsWidget> {
  Offset _tapPosition = Offset.zero;

  int isUpcoming() {
    DateTime d = DateTime.now();
    DateTime dt1 = DateTime.parse(
        "${DateTime(d.year, d.month, d.day, d.hour, d.minute).toIso8601String()}Z");
    DateTime dt2 = DateTime.parse(widget.model.inTime);
    DateTime dt3 = DateTime.parse(widget.model.outTime);
    if (dt1.compareTo(dt3) > 0) {
      //print("Booking period is over");
      return 0;
    }
    if (dt1.compareTo(dt2) < 0) {
      //print("Booking period aint started");
      return 1;
    }
    //print("Booking period is active");
    return 2;
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var rootContext = context;
    var store = context.read<CommonStore>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(stops: const [
              0.0125,
              0.0125
            ], colors: [
              widget.model.status == "rejected"
                  ? const Color.fromRGBO(179, 38, 30, 1)
                  : widget.model.status == "accepted"
                      ? const Color.fromRGBO(83, 172, 75, 1)
                      : const Color.fromRGBO(147, 144, 148, 1),
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
                  const TextSpan(
                    text: ' - ',
                  ),
                  TextSpan(
                    text: DateFormat("hh:mm a")
                        .format(DateTime.parse(widget.model.outTime)),
                  ),
                  const TextSpan(
                    text: ' · ',
                  ),
                  TextSpan(
                      text: DateFormat("dd MMMM")
                          .format(DateTime.parse(widget.model.inTime)))
                ]),
              ),
              trailing: SizedBox(
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
                      widget.model.status == 'rejected' ||
                              (widget.model.status == 'accepted' &&
                                  (isUpcoming() == 0))
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
                                    color: const Color.fromRGBO(39, 49, 65, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    context: context,
                                    position: RelativeRect.fromSize(
                                        _tapPosition & const Size(0, 0),
                                        overlay.size),
                                    items: [
                                      widget.model.status == 'requested' ||
                                              isUpcoming() == 1
                                          ? const PopupMenuItem(
                                              value: "delete",
                                              child: Text(
                                                "Delete booking",
                                                style: popupMenuStyle,
                                              ))
                                          : const PopupMenuItem(
                                              value: "end",
                                              child: Text(
                                                "End Booking",
                                                style: popupMenuStyle,
                                              ))
                                    ]);
                                if (result == "delete") {
                                  if(loading)
                                    {
                                      return;
                                    }
                                  loading = true;
                                  String res = await APIService()
                                      .deleteBooking(widget.model.id);
                                  if (res == "Success") {
                                    var snackBar = const SnackBar(
                                      content: Text('Booking deleted'),
                                      duration: Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(rootContext)
                                        .showSnackBar(snackBar);
                                    loading = false;
                                    store.delete = store.delete + 1;
                                    Navigator.of(context).pop();
                                  } else {
                                    var snackBar = SnackBar(
                                      content: Text(res),
                                      duration: const Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(rootContext)
                                        .showSnackBar(snackBar);
                                    loading = false;
                                    store.delete = store.delete + 1;
                                  }
                                } else if (result == "end") {
                                  if(loading){return;}
                                  loading = true;
                                  String res = await APIService()
                                      .endBooking(widget.model.id);
                                  if (res == "Success") {
                                    var snackBar = const SnackBar(
                                      content: Text('Booking ended'),
                                      duration: Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(rootContext)
                                        .showSnackBar(snackBar);
                                    loading = false;
                                    store.delete = store.delete + 1;
                                  } else {
                                    var snackBar = SnackBar(
                                      content: Text(res),
                                      duration: const Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(rootContext)
                                        .showSnackBar(snackBar);
                                    loading = false;
                                    store.delete = store.delete + 1;
                                  }
                                } else {
                                  print("nothing");
                                }
                              },
                              child: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 10,
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
                    child: InputDecorator(
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.zero,
                          labelText: widget.model.status == 'rejected'
                              ? 'Reason'
                              : 'Instructions',
                          labelStyle: kLabelStyle,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.56,
                                  color: Color.fromRGBO(85, 95, 113, 1)),
                              borderRadius: BorderRadius.circular(4.46))),
                      child: Text(
                        widget.model.acceptInstructions ?? '',
                        style: kReasonStyle,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
