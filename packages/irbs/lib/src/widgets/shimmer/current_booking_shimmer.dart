import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:irbs/src/models/booking_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/room_model.dart';
import '../home/current_bookings_widget.dart';


class UpcomingBookingShimmer extends StatefulWidget {
  final int number;
  const UpcomingBookingShimmer({Key? key, required this.number}) : super(key: key);

  @override
  State<UpcomingBookingShimmer> createState() => _UpcomingBookingShimmerState();
}

class _UpcomingBookingShimmerState extends State<UpcomingBookingShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(47, 48, 51, 1),
      highlightColor: Color.fromRGBO(68, 71, 79, 1),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.number,
                physics:
                const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context,
                    int index) {
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
                            roomCapacity: 1),
                        id: ' id',
                        userInfo: OwnerInfo(
                            name: '', email: '', phoneNumber: 1, rollNo: '')),
                  );
                }),
          ],
        ),
      )
    );
  }
}
