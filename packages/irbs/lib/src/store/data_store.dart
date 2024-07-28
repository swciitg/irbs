import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:irbs/src/models/room_model.dart';
import 'room_detail_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  static Map<String, dynamic> userData = {};
  static bool upcomingFlag = true;

  static bool isGuest() {
    if (userData["name"] == "Guest") {
      return true;
    }
    return false;
  }

  Future<List<RoomModel>> initialiseData(BuildContext context) async {
    userData = {};
    var rd = context.read<RoomDetailStore>();
    List<dynamic> results = await Future.wait([
      rd.getMyrooms(),
      getUserData(),
      rd.getAllRooms(),
      rd.getBookings(),
    ]);
    return results[0];
  }

  clearAll() {
    upcomingFlag = false;
    userData = {};
  }

  clear() {
    upcomingFlag = false;
  }

  Future<void> getUserData() async {
    if (userData.isEmpty) {
      SharedPreferences instance = await SharedPreferences.getInstance();
      userData = jsonDecode(instance.getString('userInfo')!);
    }
  }
}
