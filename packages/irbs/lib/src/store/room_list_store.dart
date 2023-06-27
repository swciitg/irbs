import 'package:flutter/material.dart';
class RoomListProvider with ChangeNotifier{
  List<String> commonRooms=['Yoga Room','Conf. Room','Techboard Room','Alcher Room','Exhibition Room'];
  List<String> clubRooms=['Aeromodelling Club','Automobile Club','Electronics Club','Robotics Club','Cadence Club'];
  List<String> pinnedRooms=[];
  List<String> searchResults = [];
  bool wrongKeyword = false;
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
        wrongKeyword = false;
        print("hi");
        print("__________________________");
        print(searchResults.length);
      }else{
        for (String item in commonRooms) {
          if (item.trim().toLowerCase().contains(query.toLowerCase()) ) {
            searchResults.add(item);
            wrongKeyword = false;
          }
        }
        for (String item in clubRooms) {
          if (item.trim().toLowerCase().contains(query.toLowerCase()) ) {
            searchResults.add(item);
            wrongKeyword = false;
          }
        }
        if(searchResults.isEmpty){
          wrongKeyword = true;
        }
      }

      print("_______________________");
      print(searchResults);
      print(wrongKeyword);
    notifyListeners();
  }
}