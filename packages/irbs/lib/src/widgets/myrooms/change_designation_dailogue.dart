import 'dart:convert';

import 'package:flutter/material.dart';

import '../../functions/snackbar.dart';
import '../../globals/styles.dart';
import '../../models/room_model.dart';
import '../../screens/room_details/room_details.dart';
import '../../services/api.dart';
import '../../store/data_store.dart';

Future<void> showChangeDialogue({required BuildContext context, required RoomModel room, required bool isPersonAdmin, required int index}) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ChangeDialogue(
            room: room,
            isPersonAdmin: isPersonAdmin,
            index: index);
      });
}

class ChangeDialogue extends StatefulWidget {
  final RoomModel room;
  final int index;
  final bool isPersonAdmin;
  const ChangeDialogue(
      {super.key,
        required this.index,
        required this.isPersonAdmin,
        required this.room});

  @override
  State<ChangeDialogue> createState() => _ChangeDialogueState();
}

class _ChangeDialogueState extends State<ChangeDialogue> {
  late bool changeCall;
  @override
  void initState() {
    super.initState();
    changeCall = false;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      backgroundColor: const Color.fromRGBO(39, 49, 65, 1),
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            widget.isPersonAdmin ? 'Change to Member?' : 'Change to Admin?',
            style: sentRequestStyle,
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
                    color: const Color.fromRGBO(62, 71, 88, 1),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: changeCall
                      ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator())
                      : const Text(
                    "Cancel",
                    style: dialogCancelStyle,
                  ),
                ),
              ),
              onTap: () {
                if (!changeCall) Navigator.pop(context);
              },
            ),
            InkWell(
              child: Container(
                height: 32,
                width: 144,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(118, 172, 255, 1),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: changeCall
                      ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator())
                      : const Text(
                    "Confirm",
                    style: dialogConfirmStyle,
                  ),
                ),
              ),
              onTap: () async {
                if (!changeCall) {
                  setState(() {
                    changeCall = true;
                  });
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
                  String details =
                  jsonEncode({'owner': owner, 'allowedUsers': allowed});
                  await APIService()
                      .editRoomDetails(widget.room.id, details)
                      .then((value) {
                    DataStore.myRooms
                        .removeWhere((element) => element.id == value.id);
                    DataStore.myRooms.add(value);
                    if (DataStore.rooms[widget.room.roomType] != null) {
                      DataStore.rooms[widget.room.roomType]!
                          .removeWhere((element) => element.id == value.id);
                      DataStore.rooms[value.roomType]!.add(value);
                    }
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomDetailsScreen(
                          room: value,
                        ),
                      ),
                    );
                  }).catchError((error, stackTrace) {
                    showSnackBar(error.toString());
                  });
                }
              },
            ),
          ],
        )
      ],
    );
  }
}