import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:irbs/src/models/booking_model.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:shimmer/shimmer.dart';

import '../home/request_tile.dart';

class PendingRequestShimmer extends StatefulWidget {
  const PendingRequestShimmer({Key? key}) : super(key: key);

  @override
  State<PendingRequestShimmer> createState() => _PendingRequestShimmerState();
}

class _PendingRequestShimmerState extends State<PendingRequestShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(47, 48, 51, 1),
      highlightColor: Color.fromRGBO(68, 71, 79, 1),
      child: Column(
        children: [
          CarouselSlider(
            items: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: RequestTile(
                  commonStore: CommonStore(),
                  bookingData: BookingModel(
                      roomId: 'roomId',
                      user: 'user',
                      status: '',
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: RequestTile(
                  commonStore: CommonStore(),
                  bookingData: BookingModel(
                      roomId: 'roomId',
                      user: 'user',
                      status: '',
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
                ),
              ),
            ],
            options: CarouselOptions(
              height: (167 * MediaQuery.of(context).size.width) / 360,
              padEnds: true,
              enlargeCenterPage: false,
              autoPlay: false,
              enableInfiniteScroll: false,
              viewportFraction: 0.9,
            ),
          )
        ],
      ),
    );
  }
}
