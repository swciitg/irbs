// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/room_model.dart';
part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {

  @observable
  String searchText = '';

  @observable
  ObservableMap<String, RoomModel> pinnedRooms = ObservableMap<String, RoomModel>.of({});

  @action
  initialisePinnedRooms()
  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = await prefs.getString('pinnedRooms');
    if(res != null)
      {
        Map<String,dynamic> a = jsonDecode(res);
        for(String key in a.keys)
          {
            pinnedRooms[key] = RoomModel.fromJson(a[key]);
          }
      }
    return "Success";
  }

  @action
  Future<void> addPinnedRooms(RoomModel room)
  async {
    print("g");
    pinnedRooms[room.id] = room;
    pinnedRooms = pinnedRooms;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pinnedRooms', jsonEncode(pinnedRooms));
    print("d");
  }

  @action
  Future<void> removePinnedRooms(String id)
  async {
    print("g");
    pinnedRooms.remove(id);
    pinnedRooms = pinnedRooms;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pinnedRooms', jsonEncode(pinnedRooms));
    print("d");

  }


  @action
  void setSearchText(String txt){
    searchText = txt;
  }

  @action
  void clearSearch()
  {
    searchText = '';
  }

}
