import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globals/colors.dart';
import '../globals/my_fonts.dart';
import '../models/booking_model.dart';
import '../services/api.dart';
import '../store/common_store.dart';
import '../store/data_store.dart';
import '../store/room_detail_store.dart';
import 'onboarding.dart';

class BookingDetails extends StatelessWidget {
  final BookingModel booking;
  const BookingDetails({Key? key, required this.booking}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var store = context.read<RoomDetailStore>();
    var cs = context.read<CommonStore>();
    bool isAdmin = false;
    if (store
        .getRoomById(booking.roomId)
        .owner
        .contains(DataStore.userData['outlookEmail'])) {
      isAdmin = true;
    }
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
            color: Themes.white,
          ),
        ),
        title: Text(
          "Booking Details",
          style: MyFonts.w500.size(20).setColor(Themes.white),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const OnboardingScreen()));
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
              ))
        ],
        backgroundColor: Themes.tileColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Room Name:',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 16),
            child: Text(booking.roomDetails.roomName,
              style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Start Time:',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
                children: [
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('End Time:',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
                children: [
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Booker Name:',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(booking.userInfo.name!,
              style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Booker Email:',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(booking.userInfo.email!,
              style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Booker Phone:',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text("${booking.userInfo.phoneNumber!}",
                  style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.call,
                      color: Themes.regentGrey,
                      size: 16,
                    ),
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
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Booking Purpose:',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(booking.bookingPurpose,
              style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Text('Status:',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(booking.status,
              style: MyFonts.w500.size(14).setColor(Themes.white).letterSpace(0.5),
            ),
          ),
          isAdmin && DateTime.parse(booking.outTime).isBefore(DateTime.parse("${DateTime.now().toIso8601String()}Z"))
              ? Center(
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await APIService().deleteBooking(booking.id);
                        Fluttertoast.showToast(
                            msg: 'Booking Deleted',
                            backgroundColor: Themes.white,
                            textColor: Themes.black);
                        cs.pending = cs.pending + 1;
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: 'Some Error Occured',
                            backgroundColor: Themes.white,
                            textColor: Themes.black);
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Text('Delete Booking',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            package: 'irbs',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            color: Themes.red,
                          )),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
