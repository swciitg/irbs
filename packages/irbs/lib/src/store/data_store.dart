import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:irbs/src/store/room_detail_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_store.dart';

class DataStore {
  static Map<String, dynamic> userData = {};
  static bool upcomingFlag = true;

  Future initialiseData(BuildContext context) async {
    var cs = context.read<CommonStore>();
    var rd = context.read<RoomDetailStore>();
    final results = await Future.wait([
      rd.getMyrooms(),
      getUserData(),
      rd.getAllRooms(),
      rd.getBookings(),
      cs.initialisePinnedRooms(),
      ]
    );
    return results[0];
  }

  clearAll(){
    upcomingFlag = false;
    userData = {};
  }
  clear(){
    upcomingFlag = false;
  }

  Future<void> getUserData()
  async {
    if (userData.isEmpty)
    {
      SharedPreferences instance = await SharedPreferences.getInstance();
      userData = jsonDecode(instance.getString('userInfo')!);
    }
  }


}
