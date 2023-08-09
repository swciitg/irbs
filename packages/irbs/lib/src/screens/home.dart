import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import '../models/booking_model.dart';
import '../store/common_store.dart';
import '../store/data_store.dart';
import '../store/room_detail_store.dart';
import '../widgets/home/common_rooms.dart';
import '../widgets/home/current_bookings_widget.dart';
import '../widgets/home/drawer.dart';
import '../widgets/home/empty_sate.dart';
import '../widgets/home/pending_request_carousel.dart';
import '../widgets/roomlist/list_display.dart';
import '../widgets/shimmer/home_shimmer.dart';
import 'upcoming_bookings.dart';

class HomeScreen extends StatefulWidget {
  static const id = "/irbs/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    var rd = context.read<RoomDetailStore>();

    return FutureBuilder(
      future: DataStore().initialiseData(context),
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
                  DataStore().clearAll();
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
            body: RefreshIndicator(
              onRefresh: () async {
                await DataStore().clear();
                setState(() {});
                return DataStore().initialiseData(context);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isAdmin)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18, left: 16, bottom: 10),
                        child: Text(
                          'Requests',
                          style: kSubHeadingStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    if (isAdmin) const PendingRequestCarousel(),
                   !DataStore.isGuest() ? Padding(
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
                    ): Container(),
                    !DataStore.isGuest() ? Observer(builder: (context) {
                      return rd.upcomingBookings.isEmpty
                          ? const EmptyListPlaceholder(
                              text: 'No Upcoming Bookings')
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                      padding: EdgeInsets.all(0),

                                      shrinkWrap: true,
                                      itemCount: rd.upcomingBookings.length > 3
                                          ? 3
                                          : rd.upcomingBookings.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        BookingModel ans =
                                            rd.upcomingBookings[index];

                                        return BookingTile(
                                          model: ans,
                                        );
                                      }),
                                  rd.upcomingBookings.length > 3
                                      ? GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            child: Container(
                                              height: 40,
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  color: snapshot.data!.isEmpty
                                                      ? Themes
                                                          .disabledButtonBackground
                                                      : Themes
                                                          .kCommonBoxBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: const Center(
                                                child: Text(
                                                  'View all upcoming bookings',
                                                  style: kRequestedRoomStyle,
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
                    }) : Container(),
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
