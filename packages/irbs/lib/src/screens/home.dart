import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:irbs/src/screens/error_screen.dart';
import 'package:irbs/src/widgets/shimmer/room_list_shimmer.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../store/common_store.dart';
import '../store/data_store.dart';
import '../store/room_detail_store.dart';
import '../models/room_model.dart';
import '../widgets/home/booking_card.dart';
import '../widgets/home/favourite_workspaces.dart';
import '../widgets/home/empty_sate.dart';
import '../widgets/home/pending_request_carousel.dart';
import '../widgets/roomlist/list_display.dart';
import '../widgets/shimmer/home_shimmer.dart';
import 'booking_history.dart';
import 'upcoming_bookings.dart';

class HomeScreen extends StatefulWidget {
  static const id = "/irbs/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAdmin = false;
  late Future<List<RoomModel>> _initialDataFuture;

  @override
  void initState() {
    super.initState();
    _initialDataFuture = DataStore().initialiseData(context);
  }

  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    var rd = context.read<RoomDetailStore>();

    return FutureBuilder(
      future: _initialDataFuture,
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
          backgroundColor: OColor.gray100,
          appBar: _buildAppBar(context),
          body: RefreshIndicator(
            onRefresh: () async {
              DataStore().clear();
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
                  const SizedBox(height: 16),
                  if (isAdmin) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 10),
                      child: Text(
                        'Requests',
                        style: OTextStyle.headingSmall.copyWith(
                          color: OColor.gray600,
                        ),
                      ),
                    ),
                    const PendingRequestCarousel(),
                  ],
                  const FavouriteWorkspaces(),
                  _buildYourBookings(rd),
                  _buildAllRooms(rd),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: OColor.white,
      leading: IconButton(
        icon: Icon(TablerIcons.arrow_left, color: OColor.green600),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName("/home2"));
        },
      ),
      centerTitle: true,
      title: Text(
        'SAC Room Booking',
        style: OTextStyle.labelSmall.copyWith(
          color: OColor.gray800,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildYourBookings(RoomDetailStore rd) {
    if (DataStore.isGuest()) return const SizedBox();
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Bookings',
                    style: OTextStyle.headingMedium.copyWith(
                      color: OColor.gray800,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingHistoryScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'View History',
                      style: OTextStyle.bodyXSmall.copyWith(
                        color: OColor.green600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (rd.upcomingBookings.isEmpty)
                const EmptyListPlaceholder(text: 'No Upcoming Bookings')
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount:
                      rd.upcomingBookings.length > 3
                          ? 3
                          : rd.upcomingBookings.length,
                  itemBuilder: (context, index) {
                    return BookingCard(model: rd.upcomingBookings[index]);
                  },
                ),
              if (rd.upcomingBookings.length > 3) ...[
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpcomingBookingsScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      'View all upcoming bookings',
                      style: OTextStyle.labelSmall.copyWith(
                        color: OColor.green600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAllRooms(RoomDetailStore rd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'All Rooms',
            style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder(
          future: rd.getAllRooms(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const RoomListShimmer();
            } else if (snapshot.hasError) {
              return const EmptyListPlaceholder(
                text: 'Some error occurred, try again',
              );
            }
            // Restore pinned rooms from SharedPreferences once rooms are loaded
            final cs = context.read<CommonStore>();
            cs.initialisePinnedRooms(context);
            return Column(
              children: [
                if (snapshot.data!['common'] != null &&
                    snapshot.data!['common']!.isNotEmpty)
                  ListDisplay(
                    type: 'Common Rooms',
                    roomList: snapshot.data!['common']!,
                  ),
                if (snapshot.data!['club'] != null &&
                    snapshot.data!['club']!.isNotEmpty)
                  ListDisplay(
                    type: 'Club Rooms',
                    roomList: snapshot.data!['club']!,
                  ),
                if (snapshot.data!['board'] != null &&
                    snapshot.data!['board']!.isNotEmpty)
                  ListDisplay(
                    type: 'Board Rooms',
                    roomList: snapshot.data!['board']!,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
