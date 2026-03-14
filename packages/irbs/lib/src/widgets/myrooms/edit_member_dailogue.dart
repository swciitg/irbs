import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';
import '../../functions/snackbar.dart';

import '../../models/room_model.dart';
import '../../services/api.dart';
import '../../store/room_detail_store.dart';

Future<void> showEditMemberDialogue({
  required BuildContext rootContext,
  required RoomModel room,
  required bool isPersonAdmin,
  required int index,
  required String type,
}) async {
  return showDialog(
    context: rootContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return EditMemberDailogue(
        rootContext: rootContext,
        room: room,
        type: type,
        isPersonAdmin: isPersonAdmin,
        index: index,
      );
    },
  );
}

class EditMemberDailogue extends StatefulWidget {
  final BuildContext rootContext;
  final RoomModel room;
  final int index;
  final bool isPersonAdmin;
  final String type;
  const EditMemberDailogue({
    super.key,
    required this.index,
    required this.isPersonAdmin,
    required this.room,
    required this.type,
    required this.rootContext,
  });

  @override
  State<EditMemberDailogue> createState() => _EditMemberDailogueState();
}

class _EditMemberDailogueState extends State<EditMemberDailogue> {
  bool isLoading = false;

  String get _title {
    if (widget.type == "change") {
      return widget.isPersonAdmin ? 'Change to Member?' : 'Change to Admin?';
    }
    return 'Remove member?';
  }

  String get _description {
    if (widget.type == "change") {
      return widget.isPersonAdmin
          ? 'This will change the user\'s role from Admin to Member.'
          : 'This will change the user\'s role from Member to Admin.';
    }
    return 'This action will remove the member from this room.';
  }

  IconData get _icon {
    return widget.type == "change"
        ? FluentIcons.arrow_swap_20_regular
        : FluentIcons.delete_20_regular;
  }

  Color get _iconColor {
    return widget.type == "remove" ? OColor.red500 : OColor.green600;
  }

  @override
  Widget build(BuildContext context) {
    var rd = widget.rootContext.read<RoomDetailStore>();
    return Dialog(
      backgroundColor: OColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: widget.type == "remove" ? OColor.red100 : OColor.green100,
                shape: BoxShape.circle,
              ),
              child: Icon(_icon, color: _iconColor, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              _title,
              style: OTextStyle.headingSmall.copyWith(color: OColor.gray800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _description,
              style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading ? null : () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: OColor.gray200),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: OTextStyle.labelSmall.copyWith(color: OColor.gray600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() => isLoading = true);
                            if (widget.type == "change") {
                              List<String> owner = widget.room.owner;
                              List<String> allowed = widget.room.allowedUsers;
                              String user = widget.isPersonAdmin
                                  ? owner[widget.index]
                                  : allowed[widget.index];
                              if (widget.isPersonAdmin) {
                                owner.remove(user);
                                allowed.add(user);
                              } else {
                                allowed.remove(user);
                                owner.add(user);
                              }
                              String details = jsonEncode({
                                'owner': owner,
                                'allowedUsers': allowed,
                              });
                              await APIService()
                                  .editRoomDetails(widget.room.id, details)
                                  .then((value) {
                                    rd.updateRoom(value);
                                    Navigator.pop(context);
                                  })
                                  .catchError((error, stackTrace) {
                                    showSnackBar(error.toString());
                                    setState(() => isLoading = false);
                                  });
                            } else {
                              List<String> x;
                              String user = widget.isPersonAdmin
                                  ? widget.room.owner[widget.index]
                                  : widget.room.allowedUsers[widget.index];
                              x = widget.isPersonAdmin
                                  ? widget.room.owner
                                  : widget.room.allowedUsers;
                              x.remove(user);
                              String s = widget.isPersonAdmin ? 'owner' : 'allowedUsers';
                              var details = jsonEncode({s: x});
                              await APIService()
                                  .editRoomDetails(widget.room.id, details)
                                  .then((value) {
                                    rd.updateRoom(value);
                                    Navigator.pop(context);
                                  })
                                  .catchError((error, stackTrace) {
                                    showSnackBar(error.toString());
                                    setState(() => isLoading = false);
                                  });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.type == "remove"
                          ? OColor.red500
                          : OColor.green600,
                      disabledBackgroundColor: OColor.gray200,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Confirm',
                            style: OTextStyle.labelSmall.copyWith(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
