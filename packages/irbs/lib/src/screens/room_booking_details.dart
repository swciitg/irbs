import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';

import '../globals/colors.dart';
import '../models/booking_model.dart';
import '../models/room_model.dart';
import '../services/api.dart';
import '../store/data_store.dart';
import '../store/room_detail_store.dart';
import '../widgets/roomBookingDetails/calendar.dart';
import '../widgets/roomBookingDetails/request_modal.dart';
import '../widgets/roomBookingDetails/upcoming_booking_widget.dart';
import '../widgets/shimmer/room_booking_details_shimmer.dart';
import './booking_details.dart';
import './room_details/room_details.dart';
import 'onboarding.dart';

class RoomBookingDetails extends StatefulWidget {
  final RoomModel room;

  const RoomBookingDetails({super.key, required this.room});

  @override
  State<RoomBookingDetails> createState() => _RoomBookingDetailsState();
}

class _RoomBookingDetailsState extends State<RoomBookingDetails> {
  late Future getRoomBookings;

  TextEditingController dateCtl = TextEditingController();

  Future<void> _showModal(BuildContext context) async {
    await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Themes.transparent,
      builder: (BuildContext context) {
        return RequestModal(room: widget.room, rootContext: context);
      },
    );

    setState(() {
      getRoomBookings = APIService().getBookingsForCalendar(
        roomId: widget.room.id,
        month: DateTime.now().month,
        year: DateTime.now().year,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getRoomBookings = APIService().getBookingsForCalendar(
      roomId: widget.room.id,
      month: DateTime.now().month,
      year: DateTime.now().year,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BookingModel> allBookings = [];
    List<BookingModel> latestBookings = [];
    var rd = context.read<RoomDetailStore>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(FluentIcons.arrow_left_24_regular, color: OColor.gray800),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("IRBS", style: OTextStyle.headingMedium.copyWith(color: OColor.gray800)),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => const OnboardingScreen()),
              );
              // Navigator.pushReplacementNamed(context, '/irbs/onboarding');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 11.0),
              child: Image.asset(
                'assets/question_circle.png',
                package: 'irbs',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
        backgroundColor: OColor.gray100,
      ),
      floatingActionButton:
          DataStore.isGuest()
              ? Container()
              : FloatingActionButton(
                onPressed: () {
                  _showModal(context);
                },
                backgroundColor: Themes.primaryColor,
                child: Icon(Icons.add, size: 32, color: Themes.kBackground),
              ),
      body: FutureBuilder(
        future: getRoomBookings,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const RoomBookingDetailsShimmer();
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            allBookings = [];
            latestBookings = [];
            for (var booking in snapshot.data!) {
              if (DateTime.parse(
                    booking.outTime,
                  ).toIso8601String().compareTo(DateTime.now().toLocal().toIso8601String()) ==
                  1) {
                allBookings.add(booking);
              }
            }

            allBookings.sort((a, b) => a.inTime.compareTo(b.inTime));
            allBookings.retainWhere((element) => element.status == "accepted");
            if (allBookings.length <= 2) {
              latestBookings = allBookings;
            } else {
              latestBookings = [allBookings[0], allBookings[1]];
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.room.roomName,
                          style: OTextStyle.headingLarge.copyWith(color: OColor.gray800),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          rd.setSelectedRoom(widget.room);
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const RoomDetailsScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.more_vert, color: Themes.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Divider(height: 0.5, color: Themes.white.withValues(alpha: 0.2)),
                ExpansionTile(
                  childrenPadding: const EdgeInsets.only(bottom: 12),
                  title: Text(
                    'Upcoming Bookings',
                    style: OTextStyle.bodySmall.copyWith(color: OColor.gray600),
                  ),
                  collapsedIconColor: Themes.kSubHeading,
                  iconColor: Themes.kSubHeading,
                  children:
                      latestBookings
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingDetails(booking: e),
                                  ),
                                );
                              },
                              child: UpcomingBookingsWidget(
                                name: e.userInfo.name ?? '',
                                startTime: DateFormat("hh:mm a").format(DateTime.parse(e.inTime)),
                                endTime: DateFormat("hh:mm a").format(DateTime.parse(e.outTime)),
                                date: DateFormat("dd MMMM").format(DateTime.parse(e.inTime)),
                                status:
                                    e.status == 'requested'
                                        ? 1
                                        : e.status == 'accepted'
                                        ? 2
                                        : 0,
                              ),
                            ),
                          )
                          .toList(),
                ),
                Divider(height: 0.5, color: Themes.white.withValues(alpha: 0.2)),
                Expanded(child: Calendar(roomId: widget.room.id)),
              ],
            );
          }
        },
      ),
    );
  }
}
