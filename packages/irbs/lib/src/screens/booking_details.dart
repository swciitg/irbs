import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globals/colors.dart';
import '../models/booking_model.dart';
import '../services/api.dart';
import '../store/common_store.dart';
import '../store/data_store.dart';
import '../store/room_detail_store.dart';
import 'onboarding.dart';

class BookingDetails extends StatelessWidget {
  final BookingModel booking;
  const BookingDetails({super.key, required this.booking});
  @override
  Widget build(BuildContext context) {
    var store = context.read<RoomDetailStore>();
    var cs = context.read<CommonStore>();
    bool isAdmin = false;
    if (store.getRoomById(booking.roomId).owner.contains(DataStore.userData['outlookEmail'])) {
      isAdmin = true;
    }
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
        title: Text(
          "Booking Details",
          style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('Room Name:', style: OTextStyle.bodySmall.copyWith(color: OColor.gray600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
            child: Text(
              booking.roomDetails.roomName,
              style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('Start Time:', style: OTextStyle.bodySmall.copyWith(color: OColor.gray600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
                children: [
                  TextSpan(text: DateFormat("hh:mm a").format(DateTime.parse(booking.inTime))),
                  const TextSpan(text: ' · '),
                  TextSpan(text: DateFormat("dd MMMM").format(DateTime.parse(booking.inTime))),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('End Time:', style: OTextStyle.bodySmall.copyWith(color: OColor.gray600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
                children: [
                  TextSpan(text: DateFormat("hh:mm a").format(DateTime.parse(booking.outTime))),
                  const TextSpan(text: ' · '),
                  TextSpan(text: DateFormat("dd MMMM").format(DateTime.parse(booking.outTime))),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              'Booker Name:',
              style: OTextStyle.bodySmall.copyWith(color: OColor.gray600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              booking.userInfo.name!,
              style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              'Booker Email:',
              style: OTextStyle.bodySmall.copyWith(color: OColor.gray600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              booking.userInfo.email!,
              style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              'Booker Phone:',
              style: OTextStyle.bodySmall.copyWith(color: OColor.gray600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  "${booking.userInfo.phoneNumber!}",
                  style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    child: Icon(Icons.call, color: Themes.regentGrey, size: 16),
                    onTap: () async {
                      final url = 'tel:${booking.userInfo.phoneNumber!}';
                      await launchUrl(Uri.parse(url));
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              'Booking Purpose:',
              style: OTextStyle.bodySmall.copyWith(color: OColor.gray600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              booking.bookingPurpose,
              style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('Status:', style: OTextStyle.bodySmall.copyWith(color: OColor.gray600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              booking.status,
              style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
            ),
          ),
          isAdmin &&
                  DateTime.parse(
                    booking.outTime,
                  ).isAfter(DateTime.parse("${DateTime.now().toIso8601String()}Z"))
              ? Center(
                child: GestureDetector(
                  onTap: () async {
                    bool notStarted = DateTime.parse(
                      booking.inTime,
                    ).isAfter(DateTime.parse("${DateTime.now().toIso8601String()}Z"));
                    try {
                      if (notStarted) {
                        await APIService().deleteBooking(booking.id);
                      } else {
                        await APIService().endBooking(booking.id);
                      }
                      Fluttertoast.showToast(
                        msg: notStarted ? 'Booking Deleted' : 'Booking Ended',
                        backgroundColor: Themes.white,
                        textColor: Themes.black,
                      );
                      cs.pending = cs.pending + 1;
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: 'Some Error Occured',
                        backgroundColor: Themes.white,
                        textColor: Themes.black,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      DateTime.parse(
                            booking.inTime,
                          ).isAfter(DateTime.parse("${DateTime.now().toIso8601String()}Z"))
                          ? 'Delete Booking'
                          : 'End Booking',
                      style: OTextStyle.labelSmall.copyWith(color: OColor.red500),
                    ),
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}
