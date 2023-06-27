import 'package:flutter/material.dart';
class RoomListProvider with ChangeNotifier{
  List<String> commonRooms=['Yoga Room','Conf. Room','Techboard Room','Alcher Room','Exhibition Room'];
  List<String> clubRooms=['Aeromodelling Club','Automobile Club','Electronics Club','Robotics Club','Cadence Club'];
  List<String> commonRoom=['Yoga Room','Conf. Room','Techboard Room','Alcher Room','Exhibition Room'];
  List<String> clubRoom=['Aeromodelling Club','Automobile Club','Electronics Club','Robotics Club','Cadence Club'];
  List<String> pinnedRooms=[];
  List<String> searchResults = [];
  void modifyPinnedRooms(String room){
    if (pinnedRooms.contains(room)){
      pinnedRooms.remove(room);
    }else{
      pinnedRooms.add(room);
    }
    notifyListeners();
  }
  void searchResult(String query){
      searchResults = [];
      query = query.trim();
      if(query.isEmpty){
        searchResults.clear();
      }else{
        for (String item in pinnedRooms) {
          if (item.toLowerCase().contains(query.toLowerCase()) ) {
            searchResults.add(item);
          }
        }

        for (String item in commonRooms) {
          if (item.toLowerCase().contains(query.toLowerCase()) ) {
            searchResults.add(item);
          }
        }

        for (String item in clubRooms) {
          if (item.toLowerCase().contains(query.toLowerCase()) ) {
            searchResults.add(item);
          }
        }
      }

      print("_______________________");
      print(searchResults);
    notifyListeners();
  }
}