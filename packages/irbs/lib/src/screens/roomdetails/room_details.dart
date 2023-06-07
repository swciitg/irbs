import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/roomdetails/request_modal.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../../widgets/roomdetails/upcoming_booking_widget.dart';

class RoomDetails extends StatefulWidget {
  const RoomDetails({super.key});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  TextEditingController dateCtl = TextEditingController();
  _showModal(context) {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return RequestModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        title: Text(
          "IRBS",
          style: kAppBarTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/irbs/onboarding');
              },
              icon: Image.asset(
                'assets/question_circle.png',
                package: 'irbs',
                height: 24,
                width: 24,
              ))
        ],
        backgroundColor: Themes.kCommonBoxBackground,
      ),
      floatingActionButton: FloatingActionButton(
          child: Image.asset('packages/irbs/assets/images/add.png'),
          backgroundColor: Color.fromRGBO(28, 28, 30, 1),
          onPressed: () {
            _showModal(context);
          }),
      body: Column(children: [
        Container(
          padding: EdgeInsets.only(left: 16),
          height: 60,
          color: Color.fromRGBO(39, 49, 65, 1),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Yoga Room',
                style: roomheadingStyle,
              )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Theme(
      data: Theme.of(context)
          .copyWith(unselectedWidgetColor: Color.fromRGBO(135, 145, 165, 1)),
      child: ExpansionTile(
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
        )
      ]),
    );
  }
}
