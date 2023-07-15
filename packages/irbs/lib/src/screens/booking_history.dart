import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/models/booking_model.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/widgets/home/current_bookings_widget.dart';

import '../globals/colors.dart';
import '../globals/styles.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {

  void refresh()
  {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'IRBS',
          style: appBarStyle,
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/irbs/onboarding');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 11.0),
                child: Image.asset(
                  'assets/question_circle.png',
                  package: 'irbs',
                  height: 24,
                  width: 24,
                ),
              ))
        ],
        backgroundColor: Themes.tileColor,
      ),
      body: FutureBuilder(
        future: APIService().getBookingHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('Error');
          } else {
            List<BookingModel>? currentBooking = snapshot.data?[0];
            List<BookingModel>? pastBooking = snapshot.data?[1];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
                    child: Text(
                      'Booking History',
                      style: TextStyle(
                          package: 'irbs',
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Themes.white),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'Current Bookings',
                      style: roomTypeStyle,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: currentBooking?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        BookingModel? ans = currentBooking?[index];

                        return CurrentBookingsWidget(
                          refreshHome: refresh,
                          model: ans!,
                        );
                      }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'Past Bookings',
                      style: roomTypeStyle,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: pastBooking?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        BookingModel? ans = pastBooking?[index];
                        return CurrentBookingsWidget(
                          refreshHome: refresh,
                          model: ans!,
                        );
                      }),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
