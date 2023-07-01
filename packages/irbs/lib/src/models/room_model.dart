class RoomModel {
  late List<String> owner;
  late String roomName;
  bool? bookingLocked;
  late List<String> allowedUsers;
  late String roomType;
  late int roomCapacity;
  String? instructions;
  late String id;

  RoomModel(
      {required this.owner,
        required this.roomName,
        this.bookingLocked,
        required this.allowedUsers,
        required this.roomType,
        required this.roomCapacity,
        this.instructions,
        required this.id});

  RoomModel.fromJson(Map<String, dynamic> json) {
    owner = json['owner'].cast<String>();
    roomName = json['roomName'];
    bookingLocked = json['bookingLocked'];
    allowedUsers = json['allowedUsers'].cast<String>();
    roomType = json['roomType'];
    roomCapacity = json['roomCapacity'];
    instructions = json['instructions'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['roomName'] = roomName;
    data['bookingLocked'] = bookingLocked;
    data['allowedUsers'] = allowedUsers;
    data['roomType'] = roomType;
    data['roomCapacity'] = roomCapacity;
    data['instructions'] = instructions;
    data['id'] = id;
    return data;
  }
}