import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/screens/myrooms/member_details.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/data_store.dart';

import '../../functions/snackbar.dart';
import '../../screens/room_details.dart';

class MemberTile extends StatefulWidget {
  bool isAdmin = false;
  int index;
  RoomModel room;
  bool isPersonAdmin;
  MemberTile(
      {required this.isAdmin,
      required this.index,
      required this.room,
      required this.isPersonAdmin});

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  late bool removeCall;
  Future<void> _showRemoveDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return RemoveDialog(
            room: widget.room,
            isPersonAdmin: widget.isPersonAdmin,
            index: widget.index,
          );
        });
  }

  Future<void> _showChangeDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ChangeDialog(
              room: widget.room,
              isPersonAdmin: widget.isPersonAdmin,
              index: widget.index);
        });
  }

  String name = '';
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
          foundName = true;
          break;
        }
      }
      if (!foundName) name = widget.room.owner[widget.index];
      if (widget.room.owner[widget.index] == DataStore.userData['outlookEmail'])
        isMyself = true;
    } else {
      for (var element in widget.room.allowedUserInfo) {
        if (element.email == widget.room.allowedUsers[widget.index]) {
          name = element.name!;
          foundName = true;
          break;
        }
      }
      if (!foundName) name = widget.room.allowedUsers[widget.index];
      if (widget.room.allowedUsers[widget.index] ==
          DataStore.userData['outlookEmail']) isMyself = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      // width: 328,
      padding: EdgeInsets.fromLTRB(16, 8, 0, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color.fromRGBO(39, 49, 65, 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextFormFieldStyle,
              ),
              Text(
                widget.isPersonAdmin ? 'Admin' : 'Member',
                style: designationStyle,
              )
            ],
          )),
          // if (!widget.isAdmin &&
          //     widget.designations[widget.member["designation"]])
          //   Row(
          //     children: [
          //       Text(
          //         'Admin',
          //         style: labelTextStyle,
          //       ),
          //       SizedBox(
          //         width: 24,
          //       )
          //     ],
          //   ),
          GestureDetector(
            // padding: EdgeInsets.all(0),
            onTap: () {},
            // iconSize: 20,
            child: ImageIcon(
              AssetImage('packages/irbs/assets/images/phone_icon.png'),
              size: 20,
              color: Colors.white,
            ),
          ),
          if (widget.isAdmin && !isMyself)
            Theme(
              data: Theme.of(context)
                  .copyWith(cardColor: Color.fromRGBO(39, 49, 65, 1)),
              child: PopupMenuButton(
                // offset: Offset(0, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                constraints: BoxConstraints(minWidth: 160),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                // color: Color.fromRGBO(39, 49, 65, 1),
                itemBuilder: (ctx) => [
                  _buildPopupMenuItem(
                      widget.isPersonAdmin
                          ? "Change to Member"
                          : 'Change to Admin',
                      'packages/irbs/assets/images/edit.svg',
                      1),
                  _buildPopupMenuItem("Remove",
                      'packages/irbs/assets/images/removeCross.svg', 2)
                ],
                onSelected: (value) async {
                  if (value == 1) {
                    _showChangeDialog();
                  } else if (value == 2) {
                    _showRemoveDialog();
                  }
                },
              ),
            ),
          SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }
}

PopupMenuItem _buildPopupMenuItem(String title, String iconAddress, int val) {
  return PopupMenuItem(
    value: val,
    child: Container(
      // width: 160,
      child: Row(
        children: [
          SvgPicture.asset(
            iconAddress,
            color: Colors.white,
            height: 12,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: popupMenuStyle,
          ),
        ],
      ),
    ),
  );
}

class ChangeDialog extends StatefulWidget {
  RoomModel room;
  int index;
  bool isPersonAdmin;
  ChangeDialog(
      {super.key,
      required this.index,
      required this.isPersonAdmin,
      required this.room});

  @override
  State<ChangeDialog> createState() => _ChangeDialogState();
}

class _ChangeDialogState extends State<ChangeDialog> {
  late bool changeCall;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeCall = false;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.fromLTRB(16, 24, 16, 16),
      backgroundColor: Color.fromRGBO(39, 49, 65, 1),
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            widget.isPersonAdmin ? 'Change to Member?' : 'Change to Admin?',
            style: sentRequestStyle,
          ),
        ),
        SizedBox(
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
                    color: Color.fromRGBO(62, 71, 88, 1),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: changeCall
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator())
                      : Text(
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
                    color: Color.fromRGBO(118, 172, 255, 1),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: changeCall
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator())
                      : Text(
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
                    print(value);
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
                        builder: (context) => RoomDetails(
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
    ;
  }
}

class RemoveDialog extends StatefulWidget {
  RoomModel room;
  int index;
  bool isPersonAdmin;
  RemoveDialog(
      {super.key,
      required this.index,
      required this.isPersonAdmin,
      required this.room});

  @override
  State<RemoveDialog> createState() => _RemoveDialogState();
}

class _RemoveDialogState extends State<RemoveDialog> {
  late bool removeCall;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    removeCall = false;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.fromLTRB(16, 24, 16, 16),
      backgroundColor: Color.fromRGBO(39, 49, 65, 1),
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Remove memeber?',
            style: sentRequestStyle,
          ),
        ),
        SizedBox(
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
                    color: Color.fromRGBO(62, 71, 88, 1),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: removeCall
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator())
                      : Text(
                          "Cancel",
                          style: dialogCancelStyle,
                        ),
                ),
              ),
              onTap: () {
                if (!removeCall) Navigator.pop(context);
              },
            ),
            InkWell(
              child: Container(
                height: 32,
                width: 144,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(118, 172, 255, 1),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: removeCall
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator())
                      : Text(
                          "Confirm",
                          style: dialogConfirmStyle,
                        ),
                ),
              ),
              onTap: () async {
                if (!removeCall) {
                  setState(() {
                    removeCall = true;
                  });
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
                    print(value);
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
                        builder: (context) => RoomDetails(
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
    ;
  }
}
