import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import '../models/booking_model.dart';
import '../store/common_store.dart';
import '../store/data_store.dart';
import '../widgets/home/common_rooms.dart';
import '../widgets/home/current_bookings_widget.dart';
import '../widgets/home/drawer.dart';
import '../widgets/home/empty_sate.dart';
import '../widgets/home/request_list.dart';
import '../widgets/roomlist/list_display.dart';
import '../widgets/shimmer/current_booking_shimmer.dart';
import '../widgets/shimmer/home_shimmer.dart';
import 'upcoming_bookings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    return FutureBuilder(
      future: DataStore().initialiseData(cs),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const HomeShimmer();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          if (snapshot.data!.isNotEmpty) {
            isAdmin = true;
          }
          return Scaffold(
            backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
            endDrawer: (!isAdmin) ? null : SideDrawer(),
            appBar: AppBar(
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
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
              actions: isAdmin
                  ? []
                  : [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/irbs/onboarding');
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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isAdmin)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 18, left: 16, bottom: 10),
                      child: Text(
                        'Requests',
                        style: kSubHeadingStyle.copyWith(
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  if (isAdmin) const RequestList(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 16, bottom: 7, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Bookings',
                          style: kSubHeadingStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/irbs/bookingHistory');
                          },
                          child: const Text(
                            'View History',
                            style: kTextButtonStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Observer(builder: (context) {
                    return cs.delete > 0
                        ? FutureBuilder(
                            future: DataStore().getUpcomingBookings(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const UpcomingBookingShimmer(number: 3);
                              } else if (snapshot.hasError) {
                                return const Text('Error');
                              } else {
                                List<BookingModel> currentBooking =
                                    snapshot.data!;
                                if (currentBooking.isEmpty) {
                                  return const EmptyState(
                                      text: 'No Upcoming Bookings');
                                }
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: currentBooking.length > 3
                                              ? 3
                                              : currentBooking.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            BookingModel ans =
                                                currentBooking[index];

                                            return CurrentBookingsWidget(
                                              model: ans,
                                            );
                                          }),
                                      currentBooking.length > 3
                                          ? GestureDetector(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 12),
                                                child: Container(
                                                  height: 40,
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                      color: snapshot
                                                              .data!.isEmpty
                                                          ? Themes
                                                              .disabledButtonBackground
                                                          : Themes
                                                              .kCommonBoxBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: const Center(
                                                    child: Text(
                                                      'View all upcoming bookings',
                                                      style:
                                                          kRequestedRoomStyle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const UpcomingBookingsScreen()));
                                              },
                                            )
                                          : Container(),
                                    ],
                                  ),
                                );
                              }
                            },
                          )
                        : Container();
                  }),
                  Observer(builder: (context) {
                    return ListDisplay(
                        roomList: cs.pinnedRooms.values.toList(),
                        type: 'Pinned Rooms');
                  }),
                  const CommonRooms(),
                  const SizedBox(
                    height: 108,
                  )
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        }
      },
    );
  }
}
