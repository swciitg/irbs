import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';
import '../../globals/colors.dart';

import '../../models/booking_model.dart';
import '../../models/room_model.dart';
import '../../screens/booking_history.dart';
import '../../widgets/home/common_rooms.dart';
import '../../widgets/home/current_bookings_widget.dart';
import '../../widgets/roomlist/list_display.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Icon(FluentIcons.arrow_left_24_regular, color: OColor.gray800),
        ),
        title: Text("IRBS", style: OTextStyle.headingMedium.copyWith(color: Themes.white)),
        backgroundColor: Themes.kCommonBoxBackground,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Shimmer.fromColors(
              highlightColor: Themes.allRequestShimmerHighlight,
              baseColor: Themes.allRequestShimmerBase,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 16, bottom: 7, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Bookings',
                          style: OTextStyle.headingXSmall.copyWith(color: Themes.kSubHeading),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => const BookingHistoryScreen(),
                              ),
                            );
                            // Navigator.pushNamed(
                            //     context, '/irbs/bookingHistory');
                          },
                          child: Text(
                            'View History',
                            style: OTextStyle.bodyXSmall.copyWith(
                              color: Themes.kTextButtonColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BookingTile(
                              model: BookingModel(
                                roomId: 'roomId',
                                user: 'user',
                                status: 'rejected',
                                reasonRejection: 'rejected',
                                inTime: DateTime.now().toString(),
                                outTime: DateTime.now().toString(),
                                bookingPurpose: ' bookingPurpose',
                                createdAt: 'createdAt',
                                roomDetails: RoomDetailsModel(
                                  owner: [],
                                  roomName: '',
                                  allowedUsers: [],
                                  roomType: '',
                                  roomCapacity: 1,
                                ),
                                id: ' id',
                                userInfo: OwnerInfo(
                                  name: '',
                                  email: '',
                                  phoneNumber: 1,
                                  rollNo: '',
                                ),
                              ),
                            );
                          },
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Container(
                              height: 40,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Themes.kCommonBoxBackground,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'View all upcoming bookings',
                                  style: OTextStyle.labelSmall.copyWith(color: Themes.white),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  ListDisplay(
                    type: 'Pinned Rooms',
                    roomList: [
                      RoomModel(
                        owner: [''],
                        roomName: '',
                        allowedUsers: [''],
                        roomType: 'roomType',
                        roomCapacity: 0,
                        id: ' id',
                        ownerInfo: [OwnerInfo(name: 'name', email: 'email', rollNo: 'rollNo')],
                        allowedUserInfo: [
                          OwnerInfo(name: 'name', email: 'email', rollNo: 'rollNo'),
                        ],
                      ),
                    ],
                  ),
                  const CommonRooms(),
                  const SizedBox(height: 108),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Themes.backgroundColor0Opacity, Themes.backgroundColor],
                    ),
                  ),
                ),
                Container(
                  color: Themes.backgroundColor,
                  child: Container(
                    height: 52,
                    margin: const EdgeInsets.fromLTRB(17, 0, 16, 36),
                    decoration: BoxDecoration(
                      color: Themes.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Book a Room',
                          style: OTextStyle.labelMedium.copyWith(color: OColor.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
