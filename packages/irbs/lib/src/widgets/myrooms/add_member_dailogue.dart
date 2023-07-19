import 'dart:convert';
import 'package:flutter/material.dart';
import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../../models/room_model.dart';
import '../../screens/room_details/room_details.dart';
import '../../services/api.dart';
import '../../store/data_store.dart';


Future<void> addMemberDialog(BuildContext context, RoomModel room) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AddMemberDailogue(room: room);
      });
}

class AddMemberDailogue extends StatefulWidget {
  final RoomModel room;
  const AddMemberDailogue({super.key, required this.room});

  @override
  State<AddMemberDailogue> createState() => _AddMemberDailogueState();
}

class _AddMemberDailogueState extends State<AddMemberDailogue> {
  TextEditingController emailCtl = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool checkAdmin = true;
  bool apiCall = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SimpleDialog(
        backgroundColor: const Color.fromRGBO(39, 49, 65, 1),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 0.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 24,
            child: Text(
              'Add Member',
              style: appBarStyle.copyWith(
                  color: Themes.myRoomsFormHeadingColor, fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          TextFormField(
              controller: emailCtl,
              validator: (value) {
                if (value == null || value == '') return 'Enter Email';
                if (!value.endsWith('@iitg.ac.in')) {
                  return 'Email should be IITG Mail Id';
                }
                if (widget.room.owner.contains(value) ||
                    widget.room.allowedUsers.contains(value)) {
                  return 'Already a Member';
                }
                return null;
              },
              style: permanentTextStyle,
              keyboardType: TextInputType.emailAddress,
              decoration: textFieldDecoration.copyWith(
                  labelText: "Mail ID", labelStyle: labelTextStyle)),
          const SizedBox(
            height: 18,
          ),
          CheckboxListTile(
              value: checkAdmin,
              title: Text(
                'Admin',
                style: popupMenuStyle.copyWith(fontSize: 14),
              ),
              onChanged: (bool? value) {
                setState(() {
                  checkAdmin = value!;
                });
              }),
          const SizedBox(
            height: 18,
          ),
          Container(
            height: 48,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(118, 172, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: InkWell(
                onTap: () async {
                  if (_formkey.currentState!.validate() == false) {
                    return;
                  } else {
                    if (!apiCall) {
                      setState(() {
                        apiCall = true;
                      });
                      List<String> x = checkAdmin
                          ? widget.room.owner
                          : widget.room.allowedUsers;
                      x.add(emailCtl.text);
                      String s = checkAdmin ? "owner" : "allowedUsers";
                      var details = jsonEncode({s: x});
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
                  }
                },
                child: Center(
                    child: (apiCall)
                        ? const CircularProgressIndicator()
                        : const Text(
                      'Add',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          package: 'irbs',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))),
          ),
          const SizedBox(
            height: 18,
          )
        ],
      ),
    );
  }
}