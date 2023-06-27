import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/widgets/home/common_rooms.dart';
import 'package:irbs/src/widgets/home/current_bookings_widget.dart';
import 'package:irbs/src/widgets/home/drawer.dart';
import 'package:irbs/src/widgets/home/pinned_rooms.dart';
import 'package:irbs/src/widgets/home/request.dart';
import 'package:irbs/src/widgets/home/request_list.dart';
import 'package:irbs/src/widgets/home/request_widget.dart';

class Home extends StatefulWidget {
  final bool isAdmin;

  const Home({required this.isAdmin, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
      endDrawer: (!widget.isAdmin) ? null : SideDrawer(),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "IRBS",
          style: kAppBarTextStyle,
        ),
        actions: widget.isAdmin ? [] : [
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
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              if(widget.isAdmin) Padding(
                padding: const EdgeInsets.only(top: 18, left: 16, bottom: 10),
                child: Text(
                  'Requests',
                  style: kSubHeadingStyle.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              if(widget.isAdmin)SizedBox(
                height: 167*screenWidth/360,
                child: const RequestList()),
              if(widget.isAdmin)Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Container(
                  height: 40,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Themes.kCommonBoxBackground,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Text(
                      'View all Requests',
                      style: kRequestedRoomStyle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 16, bottom: 7, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Bookings',
                      style: kSubHeadingStyle.copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/irbs/bookingHistory');
                      },
                      child: const Text(
                        'View History',
                        style: kTextButtonStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const CurrentBookingsWidget(
                status: 0,
                startTime: '10:00 AM',
                endTime: '03:00 PM',
                date: '21st April',
                roomName: 'Coding Club Room',
                data: 'eSports team have to use the room for interIIT practice ',
              ),
              const CurrentBookingsWidget(
                status: 1,
                startTime: '05:00 AM',
                endTime: '06:30 AM',
                date: '22nd April',
                roomName: 'Finesse Room',
                data: 'Do no turn off the Server Computer and turn off the AC before leaving.',
              ),
              const CurrentBookingsWidget(
                status: 2,
                startTime: '05:00 AM',
                endTime: '06:30 AM',
                date: '22nd April',
                roomName: 'Finesse Room',
              ),
              const PinnedRooms(),
              const CommonRooms(),
              const SizedBox(
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
                color: const Color.fromRGBO(28, 28, 30, 1),
                child: Container(
                  height: 52,
                  margin: const EdgeInsets.fromLTRB(17, 0, 16, 36),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/irbs/roomList');
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
