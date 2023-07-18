import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irbs/src/models/booking_model.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:irbs/src/widgets/home/current_bookings_widget.dart';
import 'package:irbs/src/widgets/home/empty_sate.dart';
import 'package:irbs/src/widgets/shimmer/current_booking_shimmer.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {

  @override
  Widget build(BuildContext context) {
    var store = context.read<CommonStore>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Booking History',
          style: appBarStyle,
        ),
        // actions: [
        //   GestureDetector(
        //       onTap: () {
        //         Navigator.pushReplacementNamed(context, '/irbs/onboarding');
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.only(right: 11.0),
        //         child: Image.asset(
        //           'assets/question_circle.png',
        //           package: 'irbs',
        //           height: 24,
        //           width: 24,
        //         ),
        //       ))
        // ],
        backgroundColor: Themes.tileColor,
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Add dropdown here
                  FutureBuilder(
                    future: APIService().getBookingHistory(month: store.month, year: store.year),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const UpcomingBookingShimmer(number: 8);
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Text('Error');
                      } else {
                        List<BookingModel> currentBooking = snapshot.data!;
                        if(currentBooking.isEmpty)
                          {
                            return EmptyState(text: 'No bookings');
                          }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: currentBooking.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  BookingModel? ans = currentBooking[index];
                                  return CurrentBookingsWidget(
                                    model: ans,
                                  );
                                }),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}