import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../../functions/launch_phone.dart';

import '../../models/room_model.dart';
import '../../store/data_store.dart';
import 'edit_member_dailogue.dart';

class MemberTile extends StatefulWidget {
  final bool isAdmin;
  final int index;
  final RoomModel room;
  final bool isPersonAdmin;
  const MemberTile({
    super.key,
    required this.isAdmin,
    required this.index,
    required this.room,
    required this.isPersonAdmin,
  });

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  late bool removeCall;

  String name = '';
  int? phone;
  bool foundName = false;
  bool isMyself = false;

  @override
  void initState() {
    super.initState();
    removeCall = false;
    if (widget.isPersonAdmin) {
      for (var element in widget.room.ownerInfo) {
        if (element.email == widget.room.owner[widget.index]) {
          name = element.name!;
          phone = element.phoneNumber;
          foundName = true;
          break;
        }
      }
      if (!foundName) name = widget.room.owner[widget.index];
      if (widget.room.owner[widget.index] == DataStore.userData['outlookEmail']) {
        isMyself = true;
      }
    } else {
      for (var element in widget.room.allowedUserInfo) {
        if (element.email == widget.room.allowedUsers[widget.index]) {
          name = element.name!;
          phone = element.phoneNumber;
          foundName = true;
          break;
        }
      }
      if (!foundName) name = widget.room.allowedUsers[widget.index];
      if (widget.room.allowedUsers[widget.index] == DataStore.userData['outlookEmail']) {
        isMyself = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: OColor.gray200, width: 0.5),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: OColor.gray100,
            child: Icon(FluentIcons.person_20_regular, color: OColor.gray400, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: widget.isPersonAdmin ? OColor.green100 : OColor.gray100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.isPersonAdmin ? 'Admin' : 'Member',
                    style: OTextStyle.bodyXSmall.copyWith(
                      color: widget.isPersonAdmin ? OColor.green600 : OColor.gray500,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (phone != null)
            GestureDetector(
              onTap: () async => await makePhoneCall(phone!.toString()),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: OColor.gray200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(FluentIcons.call_20_regular, color: OColor.green600, size: 18),
              ),
            ),
          if (widget.isAdmin && !isMyself) ...[
            const SizedBox(width: 8),
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: OColor.white,
              constraints: const BoxConstraints(minWidth: 160),
              icon: Icon(FluentIcons.more_vertical_20_regular, color: OColor.gray500, size: 20),
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.arrow_swap_20_regular,
                        size: 16,
                        color: OColor.gray600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.isPersonAdmin ? 'Change to Member' : 'Change to Admin',
                        style: OTextStyle.bodySmall.copyWith(color: OColor.gray800),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(FluentIcons.delete_20_regular, size: 16, color: OColor.red500),
                      const SizedBox(width: 8),
                      Text(
                        'Remove',
                        style: OTextStyle.bodySmall.copyWith(color: OColor.red500),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (value) async {
                showEditMemberDialogue(
                  rootContext: context,
                  room: widget.room,
                  index: widget.index,
                  isPersonAdmin: widget.isPersonAdmin,
                  type: value == 1 ? "change" : "remove",
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
