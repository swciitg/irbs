import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/store/room_detail_store.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';
import '../../models/booking_model.dart';
import '../../services/api.dart';
import '../../store/data_store.dart';

class BookingTile extends StatefulWidget {
  final BookingModel model;
  const BookingTile({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<BookingTile> createState() => _BookingTileState();
}

class _BookingTileState extends State<BookingTile> {
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
    var store = rootContext.read<RoomDetailStore>();
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
                  ?  Themes.rejectedBooking
                  : widget.model.status == "accepted"
                      ? Themes.approvedGreenColor
                      : Themes.pendingColor,
              Themes.kCommonBoxBackground
            ]),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            ListTile(
              tileColor: Themes.tileColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              title: Text(
                widget.model.roomDetails.roomName,
                // style: kRequestedRoomStyle,
                style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
              ),
              subtitle: RichText(
                text: TextSpan(
                  // style: kHeading3DescStyle,
                  style: MyFonts.w500.size(10).setColor(Themes.white).letterSpace(0.5),
                  children: [
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
                            // ? kRejectedStyle
                            ? MyFonts.w500.size(12).setColor(Themes.rejectedBooking).letterSpace(0.5)
                            : widget.model.status == 'accepted'
                                // ? kApprovedStyle
                                ? MyFonts.w500.size(12).setColor(Themes.approvedGreenColor).letterSpace(0.5)
                                // : kPendingStyle,
                                : MyFonts.w500.size(12).setColor(Themes.pendingColor).letterSpace(0.5),
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
                                    color: Themes.tileColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    context: context,
                                    position: RelativeRect.fromSize(
                                        _tapPosition & const Size(0, 0),
                                        overlay.size),
                                    items: [
                                      widget.model.status == 'requested' ||
                                              isUpcoming() == 1
                                          ? PopupMenuItem(
                                              value: "delete",
                                              child: Text(
                                                "Delete booking",
                                                // style: popupMenuStyle,
                                                style: MyFonts.w400.size(12).setColor(Themes.white).setHeight(1.219).letterSpace(0.1),
                                              ))
                                          : PopupMenuItem(
                                              value: "end",
                                              child: Text(
                                                "End Booking",
                                                // style: popupMenuStyle,
                                                style: MyFonts.w400.size(12).setColor(Themes.white).setHeight(1.219).letterSpace(0.1),
                                              ))
                                    ]);
                                if (result == "delete") {
                                  if (loading) {
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
                                    if(!mounted)return;
                                    ScaffoldMessenger.of(rootContext)
                                        .showSnackBar(snackBar);
                                    loading = false;
                                    DataStore.upcomingFlag = false;
                                    await store.setUpcomingBookings();
                                  } else {
                                    var snackBar = SnackBar(
                                      content: Text(res),
                                      duration: const Duration(seconds: 2),
                                    );
                                    if(!mounted)return;
                                    ScaffoldMessenger.of(rootContext)
                                        .showSnackBar(snackBar);
                                    loading = false;
                                    DataStore.upcomingFlag = false;
                                    await store.setUpcomingBookings();
                                  }
                                } else if (result == "end") {
                                  if (loading) {
                                    return;
                                  }
                                  loading = true;
                                  String res = await APIService()
                                      .endBooking(widget.model.id);
                                  if (res == "Success") {
                                    var snackBar = const SnackBar(
                                      content: Text('Booking ended'),
                                      duration: Duration(seconds: 2),
                                    );
                                    if(!mounted)return;
                                    ScaffoldMessenger.of(rootContext)
                                        .showSnackBar(snackBar);
                                    loading = false;
                                    DataStore.upcomingFlag = false;
                                    await store.setUpcomingBookings();
                                  } else {
                                    var snackBar = SnackBar(
                                      content: Text(res),
                                      duration: const Duration(seconds: 2),
                                    );
                                    if(!mounted)return;
                                    ScaffoldMessenger.of(rootContext)
                                        .showSnackBar(snackBar);
                                    loading = false;
                                    DataStore.upcomingFlag = false;
                                    await store.setUpcomingBookings();
                                  }
                                } else {
                                  // print("nothing");
                                }
                              },
                              child: const Icon(
                                Icons.more_vert,
                                color: Themes.white,
                                size: 20,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            (widget.model.acceptInstructions == null || widget.model.acceptInstructions == "NONE") &&
                    widget.model.reasonRejection == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 0, bottom: 12),
                    child: InputDecorator(
                      decoration: InputDecoration(
                          labelText: widget.model.status == 'rejected'
                              ? 'Reason'
                              : 'Instructions',
                          // labelStyle: kLabelStyle,
                          labelStyle: MyFonts.w500.size(8).setColor(Themes.white).letterSpace(0.5),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.56,
                                  color: Themes.comet),
                              borderRadius: BorderRadius.circular(4.46))),
                      child: Text(
                        widget.model.acceptInstructions ??
                            widget.model.reasonRejection!,
                        // style: kReasonStyle,
                        style: MyFonts.w500.size(8).setColor(Themes.reasonColor).letterSpace(0.5),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
