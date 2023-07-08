import 'dart:convert';

class MyRoomModel {
  final List<String> owner;
  final String roomName;
  final bool bookingLocked;
  final List<String> allowedUsers;
  final String roomType;
  final String id;

  MyRoomModel({
    required this.owner,
    required this.roomName,
    required this.bookingLocked,
    required this.allowedUsers,
    required this.roomType,
    required this.id,
  });

  factory MyRoomModel.fromRawJson(String str) => MyRoomModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyRoomModel.fromJson(Map<String, dynamic> json) => MyRoomModel(
    owner: List<String>.from(json["owner"].map((x) => x)),
    roomName: json["roomName"],
    bookingLocked: json["bookingLocked"],
    allowedUsers: List<String>.from(json["allowedUsers"].map((x) => x)),
    roomType: json["roomType"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "owner": List<dynamic>.from(owner.map((x) => x)),
    "roomName": roomName,
    "bookingLocked": bookingLocked,
    "allowedUsers": List<dynamic>.from(allowedUsers.map((x) => x)),
    "roomType": roomType,
    "_id": id,
  };
}
