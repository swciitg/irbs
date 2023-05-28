import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/room_tile.dart';
class ListDisplay extends StatefulWidget {
  final List<String> type;
  final bool pinned;
  ListDisplay({Key? key, required this.type, required this.pinned}) : super(key: key);

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  @override
  Widget build(BuildContext context) {
    widget.type.sort();
    return widget.type.isEmpty ? const SizedBox():ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.type.length,
        itemBuilder: (context,index){
          return RoomTile(room: widget.type[index], pinned: widget.pinned);
        }
    );
  }
}