import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/home/common_rooms.dart';
import 'package:irbs/src/widgets/home/pinned_rooms.dart';
import '../../widgets/home/current_bookings_widget.dart';
import '../../globals/styles.dart';
import '../../globals/colors.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 30, 1),
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
                Navigator.pushReplacementNamed(context, '/gc/onboarding');
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
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 18, left: 16, bottom: 10),
              //   child: Text(
              //     'Requests',
              //     style: kSubHeadingStyle,
              //   ),
              // ),
              // RequestWidget(),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   child: Container(
              //     height: 40,
              //     width: double.maxFinite,
              //     decoration: BoxDecoration(
              //         color: Themes.kCommonBoxBackground,
              //         borderRadius: BorderRadius.circular(4)),
              //     child: Center(
              //       child: Text(
              //         'View all Requests',
              //         style: kRequestedRoomStyle,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, bottom: 7, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Bookings',
                      style: kSubHeadingStyle,
                    ),
                    TextButton(
                      onPressed: (){},
                      child: Text(
                        'View History',
                        style: kTextButtonStyle,
                      ),
                    ),
                  ],
                ),
              ),
              CurrentBookingsWidget(
                status: 0,
                startTime: '10:00 AM',
                endTime: '03:00 PM',
                date: '21st April',
                roomName: 'Coding Club Room',
                data: 'eSports team have to use the room for interIIT practice ',
              ),
              CurrentBookingsWidget(
                status: 1,
                startTime: '05:00 AM',
                endTime: '06:30 AM',
                date: '22nd April',
                roomName: 'Finesse Room',
                data: 'Do no turn off the Server Computer and turn off the AC before leaving.',
              ),
              CurrentBookingsWidget(
                status: 2,
                startTime: '05:00 AM',
                endTime: '06:30 AM',
                date: '22nd April',
                roomName: 'Finesse Room',
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  height: 40,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Themes.kCommonBoxBackground,
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: Text(
                      'View Booking History',
                      style: kRequestedRoomStyle,
                    ),
                  ),
                ),
              ),
              PinnedRooms(),
              CommonRooms(),
              SizedBox(
                height: 108,
              )
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(children: [
              Container(
                height: 24,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(28, 28, 30, 0),
                          Color.fromRGBO(28, 28, 30, 1)
                        ])),
              ),
              Container(
                color: Color.fromRGBO(28, 28, 30, 1),
                child: Container(
                  height: 52,
                  margin: const EdgeInsets.fromLTRB(17, 0, 16, 36),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/gc/roomList');
                      },
                      child: const Center(
                          child: Text(
                            'Book a Room',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                package: 'irbs',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))),
                ),
              ),
            ]))
      ]),
    );
  }
}
