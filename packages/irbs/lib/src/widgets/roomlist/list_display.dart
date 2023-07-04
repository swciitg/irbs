import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/roomlist/room_tile.dart';
import '../../globals/styles.dart';
import '../../models/room_model.dart';

class ListDisplay extends StatefulWidget {
  final String type;
  final List<RoomModel> roomList;
  const ListDisplay({
    Key? key,
    required this.roomList,
    required this.type,
  }) : super(key: key);

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  @override
  Widget build(BuildContext context) {
    return widget.roomList.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.type,
                          style: roomTypeStyle,
                        )
                      ])),
              ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.roomList.length,
                  itemBuilder: (context, index) {
                    return RoomTile(
                        roomId: widget.roomList[index].id,
                        room: widget.roomList[index].roomName, pinned: false);
                  }),
            ],
          );
  }
}
