import 'package:flutter/material.dart';
import 'package:irbs/src/models/booking_model.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:irbs/src/widgets/home/request_tile.dart';
import 'package:shimmer/shimmer.dart';

class AllRequestsShimmer extends StatefulWidget {
  const AllRequestsShimmer({super.key});

  @override
  State<AllRequestsShimmer> createState() => _AllRequestsShimmerState();
}

class _AllRequestsShimmerState extends State<AllRequestsShimmer> {
  List bookings = [];

  @override
  Widget build(BuildContext context) {
    BookingModel booking = BookingModel(
      roomId: 'roomId', 
      user: 'user', 
      status: 'status', 
      inTime: DateTime.now().toString(), 
      outTime: DateTime.now().toString(), 
      bookingPurpose: 'bookingPurpose', 
      createdAt: DateTime.now().toString(), 
      roomDetails: RoomDetailsModel(
        owner: ['owner'], 
        roomName: 'roomName', 
        allowedUsers: ['allowedUsers'], 
        roomType: 'roomType', 
        roomCapacity: 10
      ), 
      id: ' id', 
      userInfo: OwnerInfo(
        name: 'name', 
        email: 'email', 
        rollNo: 'rollNo'
      ),
    );
      
    return Shimmer.fromColors(
      highlightColor: const Color.fromRGBO(68, 71, 79, 1),
      baseColor: const Color.fromRGBO(47, 48, 51, 1),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: RequestTile(bookingData: booking, commonStore: CommonStore(),),
            ),
          );
        }
      ),
    );
  }
}