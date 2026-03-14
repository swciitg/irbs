import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../../models/room_model.dart';
import '../../store/common_store.dart';
import '../home/room_detail_popup.dart';

class RoomTile extends StatelessWidget {
  final RoomModel room;
  const RoomTile({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    return GestureDetector(
      onTap: () {
        showRoomDetailPopup(context, room);
      },
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: OColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  room.roomName,
                  overflow: TextOverflow.ellipsis,
                  style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
                ),
              ),
            ),
            Observer(
              builder: (context) {
                final isPinned = cs.pinnedRooms.keys.contains(room.id);
                return GestureDetector(
                  onTap: () async {
                    if (isPinned) {
                      await cs.removePinnedRooms(room.id);
                    } else {
                      await cs.addPinnedRooms(room);
                    }
                  },
                  child: Icon(
                    isPinned
                        ? FluentIcons.star_20_filled
                        : FluentIcons.star_20_regular,
                    color: OColor.green600,
                    size: 20,
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            Icon(
              FluentIcons.chevron_right_20_regular,
              color: OColor.gray400,
              size: 20,
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
