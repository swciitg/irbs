import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:provider/provider.dart';
import '../../functions/snackbar.dart';
import '../../globals/colors.dart';

import '../../models/room_model.dart';
import '../../services/api.dart';
import '../../store/room_detail_store.dart';

Future<void> showEditMemberDialogue(
    {required BuildContext rootContext,
    required RoomModel room,
    required bool isPersonAdmin,
    required int index,
    required String type}) async {
  return showDialog(
      context: rootContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EditMemberDailogue(
            rootContext: rootContext,
            room: room,
            type: type,
            isPersonAdmin: isPersonAdmin,
            index: index);
      });
}

class EditMemberDailogue extends StatefulWidget {
  final BuildContext rootContext;
  final RoomModel room;
  final int index;
  final bool isPersonAdmin;
  final String type;
  const EditMemberDailogue(
      {super.key,
      required this.index,
      required this.isPersonAdmin,
      required this.room,
      required this.type,
      required this.rootContext});

  @override
  State<EditMemberDailogue> createState() => _EditMemberDailogueState();
}

class _EditMemberDailogueState extends State<EditMemberDailogue> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var rd = widget.rootContext.read<RoomDetailStore>();
    return SimpleDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      backgroundColor: Themes.tileColor,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            widget.type == "change"
                ? (widget.isPersonAdmin ? 'Change to Member?' : 'Change to Admin?')
                : 'Remove memeber?',
            style: OnestopFonts.w600.size(16).setColor(Themes.white),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Container(
                height: 32,
                width: 144,
                decoration: BoxDecoration(
                    color: Themes.disabledButtonBackground, borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                      : Text(
                          "Cancel",
                          style: OnestopFonts.w600
                              .size(12)
                              .setColor(Themes.white)
                              .setHeight(1.666)
                              .letterSpace(0.1),
                        ),
                ),
              ),
              onTap: () {
                if (!isLoading) Navigator.pop(context);
              },
            ),
            InkWell(
              child: Container(
                height: 32,
                width: 144,
                decoration: BoxDecoration(
                    color: Themes.primaryColor, borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                      : Text(
                          "Confirm",
                          style: OnestopFonts.w600
                              .size(12)
                              .setColor(Themes.onPrimaryColor)
                              .setHeight(1.666)
                              .letterSpace(0.1),
                        ),
                ),
              ),
              onTap: () async {
                if (widget.type == "change") {
                  if (!isLoading) {
                    setState(() {
                      isLoading = true;
                    });
                    List<String> owner = widget.room.owner;
                    List<String> allowed = widget.room.allowedUsers;
                    String user =
                        widget.isPersonAdmin ? owner[widget.index] : allowed[widget.index];
                    if (widget.isPersonAdmin) {
                      owner.remove(user);
                      allowed.add(user);
                    } else {
                      allowed.remove(user);
                      owner.add(user);
                    }
                    String details = jsonEncode({'owner': owner, 'allowedUsers': allowed});
                    await APIService().editRoomDetails(widget.room.id, details).then((value) {
                      rd.updateRoom(value);
                      Navigator.pop(context);
                    }).catchError((error, stackTrace) {
                      showSnackBar(error.toString());
                    });
                  }
                } else {
                  if (!isLoading) {
                    setState(() {
                      isLoading = true;
                    });
                    List<String> x;
                    String user = widget.isPersonAdmin
                        ? widget.room.owner[widget.index]
                        : widget.room.allowedUsers[widget.index];
                    x = widget.isPersonAdmin ? widget.room.owner : widget.room.allowedUsers;
                    x.remove(user);
                    String s = widget.isPersonAdmin ? 'owner' : 'allowedUsers';
                    var details = jsonEncode({s: x});
                    await APIService().editRoomDetails(widget.room.id, details).then((value) {
                      rd.updateRoom(value);
                      Navigator.pop(context);
                    }).catchError((error, stackTrace) {
                      showSnackBar(error.toString());
                    });
                  }
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
