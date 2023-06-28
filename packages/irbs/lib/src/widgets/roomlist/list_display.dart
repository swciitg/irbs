import 'dart:async';

import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/roomlist/room_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../store/room_list_store.dart';
class ListDisplay extends StatefulWidget {
  final List<String> type;
  ListDisplay({Key? key, required this.type,}) : super(key: key);

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  // late bool pinned;
  late List<String> pin;
  late Timer timer;

  @override
  void initState(){
    super.initState();
    pin = [];
    getPinned();
    timer=Timer.periodic(Duration(milliseconds: 100), (timer) {
      getPinned();
    });
  }
  @override
  Widget build(BuildContext context) {
    widget.type.sort();
    // final roomListProvider = Provider.of<RoomListProvider>(context);
    return widget.type.isEmpty ? const SizedBox():ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.type.length,
        itemBuilder: (context,index){
          // return RoomTile(room: widget.type[index], pinned: roomListProvider.pinnedRooms.contains(widget.type[index]));
          return RoomTile(room: widget.type[index], pinned: pin.contains(widget.type[index]));
        }
    );
  }

  Future<void> getPinned() async {
    if(!mounted)return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    pin = prefs.getStringList('pinnedRooms') ?? [];
    setState(() {

    });
  }
}