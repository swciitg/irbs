import 'dart:convert';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/booking_model.dart';
import 'common_store.dart';

class DataStore {
  static Map<String, dynamic> userData = {};
  static List<RoomModel> myRooms = [];
  static Map<String, List<RoomModel>> rooms = {};
  static List<BookingModel> upcoming = [];
  static bool upcomingFlag = true;

  Future initialiseData(CommonStore store) async {
    final results = await Future.wait([
      getMyRooms(),
      getUserData(),
      getAllRooms(),
      getUpcomingBookings(),
      store.initialisePinnedRooms(),
      ]
    );
    return results[0];
  }

  clearAll(){
    upcomingFlag = false;
    userData = {};
    myRooms = [];
    rooms = {};
  }
  clear(){
    upcomingFlag = false;
  }

  Future<List<BookingModel>> getUpcomingBookings() async {
      if(!upcomingFlag)
      {
        upcoming = await APIService().getUpcomingBokings();
      }
      return  upcoming;
  }

  Future<List<RoomModel>> getMyRooms()
  async {
    if(myRooms.isEmpty)
      {
        myRooms = await APIService().getMyRooms();
      }
    return  myRooms;
  }

  Future<void> getUserData()
  async {
    if (userData.isEmpty)
    {
      SharedPreferences instance = await SharedPreferences.getInstance();
      userData = jsonDecode(instance.getString('userInfo')!);
    }
  }

  Future<Map<String,dynamic>> getAllRooms()
  async {
    if (rooms.isEmpty)
      {
        rooms = await APIService().getAllRooms();
      }
    return rooms;
  }

  void clearMyRooms(){
    myRooms.clear();
  }

}
