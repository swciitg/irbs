import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';

import 'package:irbs/src/models/booking_model.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/screens/upcoming_bookings.dart';
import 'package:irbs/src/store/room_detail_store.dart';
import 'package:irbs/src/widgets/home/current_bookings_widget.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:provider/provider.dart';

class HomeUpcomingBookings extends StatelessWidget {
  final List<RoomModel> rooms;
  const HomeUpcomingBookings({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    final RoomDetailStore rd = context.read<RoomDetailStore>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: rd.upcomingBookings.length > 3 ? 3 : rd.upcomingBookings.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                BookingModel ans = rd.upcomingBookings[index];

                return BookingTile(model: ans);
              }),
          rd.upcomingBookings.length > 3
              ? GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Container(
                      height: 40,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: rooms.isEmpty
                              ? Themes.disabledButtonBackground
                              : Themes.kCommonBoxBackground,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'View all upcoming bookings',
                          style: OnestopFonts.w500.size(15).letterSpace(0.5).setColor(Themes.white),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const UpcomingBookingsScreen()));
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
