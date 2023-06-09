import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/bookinghistory/booking_status.dart';

import '../../globals/colors.dart';
import '../../globals/styles.dart';
class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('IRBS',
          style: appBarStyle,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.help_outline),
          ),
        ],
        backgroundColor: Themes.tileColor,
      ),
      body: SingleChildScrollView(
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16,20,16,10),
              child: Text('Booking History',
                style: TextStyle(
                  package: 'irbs',
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Themes.white
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              child: Text('Current Bookings',
                style: roomTypeStyle,
              ),
            ),
            BookingStatus(current: true,rejected: true, startTime: '8:00 AM', roomName: 'Coding Club Room', endTime: '9:00PM', date:'21st April', approved: false),
            BookingStatus(current: true,rejected: false, startTime: '8:00 AM', roomName: 'Coding Club Room', endTime: '9:00PM', date:'21st April', approved: true),
            BookingStatus(current: true,rejected: false, startTime: '8:00 AM', roomName: 'Coding Club Room', endTime: '9:00PM', date:'21st April', approved: false),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              child: Text('Past Bookings',
                style: roomTypeStyle,
              ),
            ),
            BookingStatus(current: false,rejected: false, startTime: '8:00 AM', roomName: 'Coding Club Room', endTime: '9:00PM', date:'21st April', approved: true),
            BookingStatus(current: false,rejected: false, startTime: '8:00 AM', roomName: 'Coding Club Room', endTime: '9:00PM', date:'21st April', approved: false),
            BookingStatus(current: false,rejected: false, startTime: '8:00 AM', roomName: 'Coding Club Room', endTime: '9:00PM', date:'21st April', approved: true),
            BookingStatus(current: false,rejected: false, startTime: '8:00 AM', roomName: 'Coding Club Room', endTime: '9:00PM', date:'21st April', approved: false),
          ],
        ),
      ),
    );
  }
}
