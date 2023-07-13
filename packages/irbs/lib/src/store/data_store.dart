// import 'package:aad_oauth/aad_oauth.dart';
// import 'package:aad_oauth/model/config.dart';

import 'dart:convert';

import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  static Map<String, dynamic> userData = {};
  static List<RoomModel> myRooms = [];
  static Map<String, List<RoomModel>> rooms = {};


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



}
