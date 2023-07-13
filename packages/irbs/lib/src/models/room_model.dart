class RoomModel {
  late List<String> owner;
  late String roomName;
  bool? bookingLocked;
  late List<String> allowedUsers;
  late String roomType;
  late int roomCapacity;
  String? instructions;
  late String id;
  late List<OwnerInfo> ownerInfo;
  late List<OwnerInfo> allowedUserInfo;
  RoomModel(
      {required this.owner,
      required this.roomName,
      this.bookingLocked,
      required this.allowedUsers,
      required this.roomType,
      required this.roomCapacity,
      this.instructions,
      required this.id,
      required this.ownerInfo,
      required this.allowedUserInfo});

  RoomModel.fromJson(Map<String, dynamic> json) {
    owner = json['owner'].cast<String>();
    roomName = json['roomName'];
    bookingLocked = json['bookingLocked'];
    allowedUsers = json['allowedUsers'].cast<String>();
    roomType = json['roomType'];
    roomCapacity = json['roomCapacity'];
    instructions = json['instructions'];
    id = json['id'];
    ownerInfo = <OwnerInfo>[];
    json['ownerInfo'].forEach((v) {
      ownerInfo.add(OwnerInfo.fromJson(v));
    });
    allowedUserInfo = <OwnerInfo>[];
        json['allowedUserInfo'].forEach((v) {
            allowedUserInfo.add(OwnerInfo.fromJson(v));
          });
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
    data['ownerInfo'] = ownerInfo.map((v) => v.toJson()).toList();
    data['allowedUserInfo'] = allowedUserInfo.map((v) => v.toJson()).toList();
    return data;
  }
}

class OwnerInfo {
  String? name;
  String? email;
  String? rollNo;
  int? phoneNumber;
  String? hostel;

  OwnerInfo(
      {required this.name,
      required this.email,
      required this.rollNo,
      this.phoneNumber,
      this.hostel});

  OwnerInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    rollNo = json['rollNo'];
    phoneNumber = json['phoneNumber'];
    hostel = json['hostel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['rollNo'] = rollNo;
    data['phoneNumber'] = phoneNumber;
    data['hostel'] = hostel;
    return data;
  }
}
