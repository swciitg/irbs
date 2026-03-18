import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';

import 'room_tile.dart';
import '../../models/room_model.dart';

class ListDisplay extends StatelessWidget {
  final String type;
  final List<RoomModel> roomList;
  const ListDisplay({super.key, required this.roomList, required this.type});

  @override
  Widget build(BuildContext context) {
    if (roomList.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                type,
                style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
              ),
              const SizedBox(height: 8),
              Divider(height: 1, color: OColor.gray200),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ListView.separated(
          padding: const EdgeInsets.all(0),
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: roomList.length,
          itemBuilder: (context, index) {
            return RoomTile(room: roomList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: OColor.gray200,
              height: 0,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            );
          },
        ),
      ],
    );
  }
}
