import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';
import '../../models/booking_model.dart';
import '../../models/room_model.dart';
import '../../store/common_store.dart';
import '../home/request_tile.dart';
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
      highlightColor: Themes.allRequestShimmerHighlight,
      baseColor: Themes.allRequestShimmerBase,
      child: ListView.builder(
          padding: const EdgeInsets.all(0),

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