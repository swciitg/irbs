import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../../models/room_model.dart';
import '../../store/common_store.dart';
import '../home/room_detail_popup.dart';

class FavouriteWorkspaces extends StatelessWidget {
  const FavouriteWorkspaces({super.key});

  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        if (cs.pinnedRooms.isEmpty) return const SizedBox();
        final rooms = cs.pinnedRooms.values.toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favourite Workspaces',
                style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 175 / 40,
                ),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return _FavouriteButton(room: rooms[index]);
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

class _FavouriteButton extends StatelessWidget {
  final RoomModel room;
  const _FavouriteButton({required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showRoomDetailPopup(context, room);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: OColor.white,
          border: Border.all(color: OColor.green600, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            room.roomName,
            overflow: TextOverflow.ellipsis,
            style: OTextStyle.labelSmall.copyWith(color: OColor.green600),
          ),
        ),
      ),
    );
  }
}
