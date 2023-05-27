import 'package:flutter/material.dart';
class RoomListProvider with ChangeNotifier{
  List<String> commonRooms=['Yoga Room','Conf. Room','Techboard Room','Alcher Room','Exhibition Room'];
  List<String> clubRooms=['Aeromodelling Club','Automobile Club','Electronics Club','Robotics Club','Cadence Club'];
  List<String> commonRoom=['Yoga Room','Conf. Room','Techboard Room','Alcher Room','Exhibition Room'];
  List<String> clubRoom=['Aeromodelling Club','Automobile Club','Electronics Club','Robotics Club','Cadence Club'];
  List<String> pinnedRooms=[];
  bool ispinned=false;
  void modifyPinnedRooms(String room){
    if (pinnedRooms.contains(room)){
      pinnedRooms.remove(room);
      if(commonRoom.contains(room)){
        commonRooms.add(room);
      }
      if(clubRoom.contains(room)){
        clubRooms.add(room);
      }
    }else{
      pinnedRooms.add(room);
      if(commonRoom.contains(room)){
        commonRooms.remove(room);
        print(commonRooms.length);
      }
      if(clubRoom.contains(room)){
        clubRooms.remove(room);
      }
    }
    print("pinnedRooms: ${pinnedRooms}");
    print("clubRooms: ${clubRooms}");
    print("commonRooms: ${commonRooms}");
    notifyListeners();
  }
}