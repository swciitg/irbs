import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onestop_kit/onestop_kit.dart';
import '../../functions/launch_phone.dart';
import '../../globals/colors.dart';

import '../../models/room_model.dart';
import '../../store/data_store.dart';
import 'edit_member_dailogue.dart';

class MemberTile extends StatefulWidget {
  final bool isAdmin;
  final int index;
  final RoomModel room;
  final bool isPersonAdmin;
  const MemberTile(
      {super.key,
      required this.isAdmin,
      required this.index,
      required this.room,
      required this.isPersonAdmin});

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
      height: 54,
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Themes.tileColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: OnestopFonts.w500.size(14).setColor(Themes.white),
              ),
              Text(
                widget.isPersonAdmin ? 'Admin' : 'Member',
                style: OnestopFonts.w400
                    .size(10)
                    .setColor(Themes.white)
                    .setHeight(1.2)
                    .letterSpace(0.1),
              )
            ],
          )),
          GestureDetector(
            onTap: () async {
              if (phone != null) {
                await makePhoneCall(phone!.toString());
              }
            },
            child: ImageIcon(
              const AssetImage('packages/irbs/assets/images/phone_icon.png'),
              size: 20,
              color: phone != null ? Themes.white : Themes.grey,
            ),
          ),
          if (widget.isAdmin && !isMyself)
            Theme(
              data: Theme.of(context).copyWith(cardColor: Themes.tileColor),
              child: PopupMenuButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                constraints: const BoxConstraints(minWidth: 160),
                icon: const Icon(
                  Icons.more_vert,
                  color: Themes.white,
                ),
                itemBuilder: (ctx) => [
                  buildPopupMenuItem(widget.isPersonAdmin ? "Change to Member" : 'Change to Admin',
                      'packages/irbs/assets/images/edit.svg', 1),
                  buildPopupMenuItem("Remove", 'packages/irbs/assets/images/removeCross.svg', 2)
                ],
                onSelected: (value) async {
                  showEditMemberDialogue(
                      rootContext: context,
                      room: widget.room,
                      index: widget.index,
                      isPersonAdmin: widget.isPersonAdmin,
                      type: value == 1 ? "change" : "remove");
                },
              ),
            ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }
}

PopupMenuItem buildPopupMenuItem(String title, String iconAddress, int val) {
  return PopupMenuItem(
    value: val,
    child: Row(
      children: [
        SvgPicture.asset(
          iconAddress,
          height: 12,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style:
              OnestopFonts.w400.size(12).setColor(Themes.white).setHeight(1.219).letterSpace(0.1),
        ),
      ],
    ),
  );
}
