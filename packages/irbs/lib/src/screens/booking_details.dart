import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/models/booking_model.dart';
import 'package:irbs/src/services/api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globals/colors.dart';
import '../globals/styles.dart';
class BookingDetails extends StatelessWidget {
  BookingModel booking;
  BookingDetails({Key? key, required this.booking}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        title:  Text(
          "Booking Details",
          style: kAppBarTextStyle,
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
        backgroundColor: Themes.kCommonBoxBackground,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Room Name:',style: subHeadingStyle,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 16),
            child: Text(booking.roomDetails.roomName,
              style: kBookingDetailStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Start Time:',style: subHeadingStyle,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(style: kBookingDetailStyle, children: [
                TextSpan(
                  text: DateFormat("hh:mm a")
                      .format(DateTime.parse(booking.inTime)),
                ),
                const TextSpan(
                  text: ' · ',
                ),
                TextSpan(
                    text: DateFormat("dd MMMM")
                        .format(DateTime.parse(booking.inTime)))
              ]),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('End Time:',style: subHeadingStyle,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(style: kBookingDetailStyle, children: [
                TextSpan(
                  text: DateFormat("hh:mm a")
                      .format(DateTime.parse(booking.outTime)),
                ),
                const TextSpan(
                  text: ' · ',
                ),
                TextSpan(
                    text: DateFormat("dd MMMM")
                        .format(DateTime.parse(booking.outTime)))
              ]),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Booker Name:',style: subHeadingStyle,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(booking.userInfo.name!,
              style: kBookingDetailStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Booker Email:',style: subHeadingStyle,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(booking.userInfo.email!,
              style: kBookingDetailStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Booker Phone:',style: subHeadingStyle,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text("${booking.userInfo.phoneNumber!}",
                  style: kBookingDetailStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    child: const Icon(Icons.call,color: Themes.kSubHeading, size: 16,),
                    onTap: () async{
                      final url = 'tel:${booking.userInfo.phoneNumber!}';
                      await launchUrl(Uri.parse(url));
                    },
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Booking Purpose:',style: subHeadingStyle,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(booking.bookingPurpose,
              style: kBookingDetailStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Status:',style: subHeadingStyle,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(booking.status,
              style: kBookingDetailStyle,
            ),
          ),
        ],
      ),
    );
  }
}
