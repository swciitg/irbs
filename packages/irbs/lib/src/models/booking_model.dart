import 'package:irbs/src/models/room_model.dart';

class BookingModel {
  String roomId = '';
  String user = '';
  String status = '';

  //TODO convert this string to datetime approriately
  String inTime = '';
  String outTime = '';
  String bookingPurpose = '';
  String acceptInstructions = '';
  String createdAt = '';
  String id = '';
  late RoomModel roomDetails;
  BookingModel(
      {required this.roomId,
        required this.user,
        required this.status,
        required this.inTime,
        required this.outTime,
        required this.bookingPurpose,
        required this.acceptInstructions,
        required this.createdAt,
        required this.roomDetails,
        required this.id});

  BookingModel.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    user = json['user'];
    status = json['status'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    bookingPurpose = json['bookingPurpose'];
    acceptInstructions = json['acceptInstructions'];
    createdAt = json['createdAt'];
    id = json['id'];
    roomDetails= new RoomModel.fromJson(json['roomDetails']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomId'] = roomId;
    data['user'] = user;
    data['status'] = status;
    data['inTime'] = inTime;
    data['outTime'] = outTime;
    data['bookingPurpose'] = bookingPurpose;
    data['acceptInstructions'] = acceptInstructions;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['roomDetails']=roomDetails.toJson();
    return data;
  }
}