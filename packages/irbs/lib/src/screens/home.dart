import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/screens/error_screen.dart';
import 'package:irbs/src/widgets/home/home_upcoming_bookings.dart';
import 'package:irbs/src/widgets/shimmer/room_list_shimmer.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:provider/provider.dart';
import '../screens/room_list.dart';
import '../globals/colors.dart';
import '../store/common_store.dart';
import '../store/data_store.dart';
import '../store/room_detail_store.dart';
import '../widgets/home/common_rooms.dart';
import '../widgets/home/drawer.dart';
import '../widgets/home/empty_sate.dart';
import '../widgets/home/pending_request_carousel.dart';
import '../widgets/roomlist/list_display.dart';
import '../widgets/shimmer/home_shimmer.dart';
import 'booking_history.dart';
import 'onboarding.dart';

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const HomeShimmer();
        } else if (snapshot.hasError || !snapshot.hasData) {
          return ErrorScreen(
            reloadCallback: () {
              setState(() {});
            },
          );
        }

        if (snapshot.data!.isNotEmpty) {
          isAdmin = true;
        }
        return Scaffold(
          backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
          endDrawer: (!isAdmin) ? null : const SideDrawer(),
          appBar: _buildAppBar(context),
          body: RefreshIndicator(
            onRefresh: () async {
              await DataStore().clear();
              setState(() {
                cs.pending++;
              });
              if (!mounted) return;
              await DataStore().initialiseData(context);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isAdmin)
                    Padding(
                      padding: const EdgeInsets.only(top: 18, left: 16, bottom: 10),
                      child: Text(
                        'Requests',
                        style: OnestopFonts.w600
                            .setColor(Themes.kSubHeading)
                            .size(14)
                            .letterSpace(0.5),
                      ),
                    ),
                  if (isAdmin) const PendingRequestCarousel(),
                  _buildCurrentBookingTitle(DataStore.isGuest()),
                  _buildUpcomingBookings(context, rd, snapshot.data!),
                  _buildPinnedRooms(cs),
                  const CommonRooms(),
                  const SizedBox(height: 108)
                ],
              ),
            ),
          ),
          floatingActionButton: _buildRoomBookButton(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          DataStore().clearAll();
          Navigator.of(context, rootNavigator: true).pop();
        },
        child: const Icon(
          Icons.arrow_back_sharp,
          color: Themes.white,
        ),
      ),
      title: Text(
        "IRBS",
        style: OnestopFonts.w500.size(20).setColor(Themes.white),
      ),
      actions: _buildAppBarActions(context),
      backgroundColor: Themes.kCommonBoxBackground,
    );
  }

  Observer _buildPinnedRooms(CommonStore cs) {
    return Observer(
      builder: (context) {
        if (cs.pinnedRooms.isEmpty) return const SizedBox();
        return FutureBuilder(
          future: CommonStore().initialisePinnedRooms(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const RoomListShimmer();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              if (snapshot.data!.isNotEmpty) {
                isAdmin = true;
              }
              return ListDisplay(roomList: cs.pinnedRooms.values.toList(), type: 'Pinned Rooms');
            }
          },
        );
      },
    );
  }

  Widget _buildRoomBookButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 52,
        margin: const EdgeInsets.fromLTRB(17, 0, 16, 36),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(118, 172, 255, 1),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const RoomListScreen(),
              ),
            );
          },
          child: Center(
            child: Text('Book a Room', style: OnestopFonts.w700.size(16)),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentBookingTitle(bool isGuest) {
    if (isGuest) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, bottom: 7, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Current Bookings',
            style: OnestopFonts.w600.setColor(Themes.kSubHeading).size(14).letterSpace(0.5),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const BookingHistoryScreen(),
                ),
              );
            },
            child: Text(
              'View History',
              style: OnestopFonts.w400
                  .size(12)
                  .letterSpace(0.5)
                  .underline()
                  .setColor(Themes.kTextButtonColor),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    if (isAdmin) return [];
    return [
      GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const OnboardingScreen(),
            ),
          );
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
      )
    ];
  }

  Widget _buildUpcomingBookings(BuildContext context, RoomDetailStore rd, List<RoomModel> rooms) {
    return !DataStore.isGuest()
        ? Observer(
            builder: (context) {
              return rd.upcomingBookings.isEmpty
                  ? const EmptyListPlaceholder(text: 'No Upcoming Bookings')
                  : HomeUpcomingBookings(rooms: rooms);
            },
          )
        : const SizedBox();
  }
}
