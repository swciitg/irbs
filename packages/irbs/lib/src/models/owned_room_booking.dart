import 'package:irbs/src/models/booking_model.dart';

class OwnedRoomBooking{
  late String roomId;
  late String user;
  late String status;
  late String inTime;
  late String outTime;
  late String bookingPurpose;
  late String createdAt;
  late String id;
  late RoomDetailsModel roomDetails;

  OwnedRoomBooking({
    required this.roomId,
    required this.user,
    required this.status,
    required this.inTime,
    required this.outTime,
    required this.bookingPurpose,
    required this.createdAt,
    required this.id,
    required this.roomDetails
  });

  OwnedRoomBooking.fromJson(Map<String, dynamic> json){
    roomId = json['roomId'];
    user = json['user'];
    status = json['status'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    bookingPurpose = json['bookingPurpose'];
    createdAt = json['createdAt'];
    id = json['id'];
    roomDetails = RoomDetailsModel.fromJson(json['roomDetails']);
  }
}