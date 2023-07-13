import 'package:irbs/src/models/room_model.dart';

class BookingModel {
  String roomId = '';
  String user = '';
  String status = '';

  //TODO convert this string to datetime approriately
  String inTime = '';
  String outTime = '';
  String bookingPurpose = '';
  String? acceptInstructions;
  String createdAt = '';
  String id = '';
  late RoomDetails roomDetails;
  late OwnerInfo userInfo;
  BookingModel(
      {required this.roomId,
      required this.user,
      required this.status,
      required this.inTime,
      required this.outTime,
      required this.bookingPurpose,
      this.acceptInstructions,
      required this.createdAt,
      required this.roomDetails,
      required this.id,
      required this.userInfo});

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
    roomDetails = RoomDetails.fromJson(json['roomDetails']);
    userInfo = OwnerInfo.fromJson(json['userInfo']);
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
    data['roomDetails'] = roomDetails.toJson();
    data['userInfo'] = userInfo.toJson();
    return data;
  }
}

class RoomDetails {
  late List<String> owner;
  late String roomName;
  late List<String> allowedUsers;
  late String roomType;
  late int roomCapacity;

  RoomDetails(
      {required this.owner,
      required this.roomName,
      required this.allowedUsers,
      required this.roomType,
      required this.roomCapacity});

  RoomDetails.fromJson(Map<String, dynamic> json) {
    owner = json['owner'].cast<String>();
    roomName = json['roomName'];
    allowedUsers = json['allowedUsers'].cast<String>();
    roomType = json['roomType'];
    roomCapacity = json['roomCapacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['roomName'] = roomName;
    data['allowedUsers'] = allowedUsers;
    data['roomType'] = roomType;
    data['roomCapacity'] = roomCapacity;
    return data;
  }
}
