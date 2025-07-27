import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../models/booking_model.dart';
import '../services/api.dart';
import '../store/common_store.dart';
import '../widgets/drop_down.dart';
import '../widgets/home/current_bookings_widget.dart';
import '../widgets/home/empty_sate.dart';
import '../widgets/shimmer/current_booking_shimmer.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    var store = context.read<CommonStore>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Booking History',
          style: OnestopFonts.w500.size(20).setColor(Themes.white),
        ),
        backgroundColor: Themes.tileColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 130, child: CustomDropDown(hintText: 'Month')),
                    SizedBox(width: 130, child: CustomDropDown(hintText: 'Year')),
                  ],
                ),
              ),
              Observer(builder: (context) {
                return FutureBuilder(
                  future: APIService().getBookingHistory(month: store.month, year: store.year),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const UpcomingBookingShimmer(number: 8);
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      List<BookingModel> currentBooking = snapshot.data!;
                      if (currentBooking.isEmpty) {
                        return const EmptyListPlaceholder(text: 'No bookings');
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemCount: currentBooking.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                BookingModel? ans = currentBooking[index];
                                return BookingTile(
                                  model: ans,
                                );
                              }),
                        ],
                      );
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
