import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/models/booking_model.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/widgets/home/common_rooms.dart';
import 'package:irbs/src/widgets/home/current_bookings_widget.dart';
import 'package:irbs/src/widgets/roomlist/list_display.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
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
        backgroundColor: Themes.kCommonBoxBackground,
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Shimmer.fromColors(
            highlightColor: const Color.fromRGBO(68, 71, 79, 1),
            baseColor: const Color.fromRGBO(47, 48, 51, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return CurrentBookingsWidget(
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
                                roomCapacity: 1
                              ),
                              id: ' id',
                              userInfo: OwnerInfo(
                                name: '', 
                                email: '', 
                                phoneNumber: 1, 
                                rollNo: ''
                              ),
                            ),
                          );
                        }
                      ),
                      GestureDetector(
                        child: Padding(
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
                                'View all upcoming bookings',
                                style: kRequestedRoomStyle,
                              ),
                            ),
                          ),
                        ),
                        onTap: (){},
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
                      ownerInfo: [
                        OwnerInfo(
                          name: 'name', 
                          email: 'email', 
                          rollNo: 'rollNo'
                        ),
                      ], 
                      allowedUserInfo: [
                        OwnerInfo(
                          name: 'name', 
                          email: 'email', 
                          rollNo: 'rollNo'
                        ),
                      ]
                    ),
                  ],
                ),
                const CommonRooms(),
                const SizedBox(
                  height: 108,
                )
              ],
            ),
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
                      onTap: (){},
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