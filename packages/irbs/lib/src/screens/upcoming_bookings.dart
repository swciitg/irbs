import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../models/booking_model.dart';

import '../store/room_detail_store.dart';
import '../widgets/home/current_bookings_widget.dart';
import '../widgets/home/empty_sate.dart';

class UpcomingBookingsScreen extends StatefulWidget {
  const UpcomingBookingsScreen({super.key});
  @override
  State<UpcomingBookingsScreen> createState() => _UpcomingBookingsScreenState();
}

class _UpcomingBookingsScreenState extends State<UpcomingBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    var rd = context.read<RoomDetailStore>();

    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upcoming Booking',
          style: OnestopFonts.w500.size(20).setColor(Colors.white),
        ),
        backgroundColor: Themes.tileColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          child: Observer(builder: (context) {
            return rd.upcomingBookings.isEmpty
                ? const EmptyListPlaceholder(text: 'No bookings')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: rd.upcomingBookings.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            BookingModel? ans = rd.upcomingBookings[index];
                            return BookingTile(
                              model: ans,
                            );
                          }),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
