
class BookingModel  {
  late String roomId = '';
  late String user = '';
  late String status = '';

  //TODO convert this late string to datetime approriately
  late String inTime = '';
  late String outTime = '';
  late String bookingPurpose = '';
  late String acceptInstructions = '';
  late String createdAt = '';
  late String id = '';
  late UserInfo userInfo ;
  RoomDetails roomDetails = RoomDetails(
      owner: [],
      roomName: '',
      allowedUsers: [],
      roomType: '',
      roomCapacity: 1);

  BookingModel({required this.roomId,
    required this.user,
    required this.status,
    required this.inTime,
    required this.outTime,
    required this.bookingPurpose,
    required this.acceptInstructions,
    required this.createdAt,
    required this.id,
    required this.roomDetails,
    required this.userInfo,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    user = json['user']  ;
    status = json['status'] ;
    inTime = json['inTime'] ;
    outTime = json['outTime'] ;
    bookingPurpose = json['bookingPurpose'];
    acceptInstructions = json['acceptInstructions'] ?? ' ';
    createdAt = json['createdAt'];
    id = json['id'] ;
    roomDetails = RoomDetails.fromJson(json['roomDetails']);
    userInfo = UserInfo.fromJson(json['userInfo']);
  }
}
class RoomDetails{
   List<dynamic> owner=[];
   String roomName='';
   List<dynamic> allowedUsers=[];
   String roomType='';
   int roomCapacity=1;

  RoomDetails({
    required this.owner,
    required this.roomName,
    required this.allowedUsers,
    required this.roomType,
    required this.roomCapacity,
  });
   RoomDetails.fromJson(Map<String, dynamic> json) {
     owner = json['owner'] ;
     roomName = json['roomName'];
     allowedUsers = json['allowedUsers']??'';
     roomType = json['roomType'];
     roomCapacity = json['roomCapacity'];
   }
}
class UserInfo {
   String name= '';
   String email= '';
   String rollNo= '';
   int? phoneNumber;

  UserInfo({
    required this.name,
    required this.email,
    required this.rollNo,
     this.phoneNumber,
  });
  UserInfo.fromJson(Map<String,dynamic> json){

    name = json['name'] ;
    email = json['email'];
    rollNo = json['rollNo'];

    phoneNumber = json['phoneNumber']?? 9;

  }
}
