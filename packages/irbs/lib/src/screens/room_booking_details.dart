import 'package:flutter/material.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/screens/room_details.dart';
import 'package:irbs/src/widgets/roomdetails/calendar.dart';
import 'package:irbs/src/widgets/roomdetails/request_modal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import '../widgets/roomdetails/upcoming_booking_widget.dart';

class RoomBookingDetails extends StatefulWidget {
  final RoomModel room;
  const RoomBookingDetails({super.key, required, required this.room});

  @override
  State<RoomBookingDetails> createState() => _RoomBookingDetailsState();
}

class _RoomBookingDetailsState extends State<RoomBookingDetails> {
  CalendarView view = CalendarView.month;

  TextEditingController dateCtl = TextEditingController();
  _showModal(context) {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return const RequestModal();
        });
  }

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
        title: const Text(
          "IRBS",
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
          onPressed: () {
            _showModal(context);
          },
          child: Image.asset(
            'packages/irbs/assets/images/add.png',
            fit: BoxFit.contain,
          )),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          height: 60,
          //color: const Color.fromRGBO(39, 49, 65, 1),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                widget.room.roomName,
                style: roomheadingStyle,
              )),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoomDetails(isAdmin: true, roomModel: widget.room,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Theme(
          data: Theme.of(context).copyWith(
              unselectedWidgetColor: const Color.fromRGBO(135, 145, 165, 1)),
          child: const ExpansionTile(
            title: Text(
              'UpcomingBookings',
              style: subHeadingStyle,
            ),
            children: [
              UpcomingBookingsWidget(
                status: 2,
                name: 'Aarya Ghodke',
                startTime: '10:00 AM',
                endTime: '03:00 PM',
                date: '21st April',
              ),
              UpcomingBookingsWidget(
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
        ),
        Divider(
          height: 0.5,
          color: Colors.white.withOpacity(0.2),
        ),
        const Expanded(child: Calendar()),
      ]),
    );
  }
}
