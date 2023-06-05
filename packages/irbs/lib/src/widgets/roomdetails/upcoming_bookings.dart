import 'package:flutter/material.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/widgets/home/current_bookings_widget.dart';

class UpcomingBookings extends StatefulWidget {
  const UpcomingBookings({super.key});

  @override
  State<UpcomingBookings> createState() => _UpcomingBookingsState();
}

class _UpcomingBookingsState extends State<UpcomingBookings> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(unselectedWidgetColor: Color.fromRGBO(135, 145, 165, 1)),
      child: ExpansionTile(
        title: Text(
          'UpcomingBookings',
          style: subHeadingStyle,
        ),
        children: [
          CurrentBookingsWidget(
            status: 2,
            name: 'Aarya Ghodke',
            startTime: '10:00 AM',
            endTime: '03:00 PM',
            date: '21st April',
          ),
          CurrentBookingsWidget(
            status: 1,
            name: 'Chandu Mandu',
            startTime: '05:00 AM',
            endTime: '06:30 PM',
            date: '22nd April',
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
