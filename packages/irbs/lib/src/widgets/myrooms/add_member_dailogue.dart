import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';

import '../../globals/styles.dart';
import '../../services/api.dart';
import '../../store/room_detail_store.dart';

Future<void> addMemberDialog(BuildContext rootContext) async {
  return showDialog(
    barrierDismissible: false,
    context: rootContext,
    builder: (context) {
      return AddMemberDailogue(rootContext: rootContext);
    },
  );
}

class AddMemberDailogue extends StatefulWidget {
  final BuildContext rootContext;
  const AddMemberDailogue({super.key, required this.rootContext});

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
    var rd = widget.rootContext.read<RoomDetailStore>();
    return Form(
      key: _formkey,
      child: SimpleDialog(
        backgroundColor: Themes.tileColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 0.0),
                child: Icon(Icons.close, color: Themes.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 24,
            child: Text(
              'Add Member',
              style: OTextStyle.headingMedium.copyWith(
                color: Themes.myRoomsFormHeadingColor,
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: emailCtl,
            validator: (value) {
              if (value == null || value == '') return 'Enter Email';
              if (!value.endsWith('@iitg.ac.in')) {
                return 'Email should be IITG Mail Id';
              }
              if (rd.currentRoom.owner.contains(value) ||
                  rd.currentRoom.allowedUsers.contains(value)) {
                return 'Already a Member';
              }
              return null;
            },
            style: OTextStyle.labelSmall.copyWith(color: Themes.permanentTextColor),
            keyboardType: TextInputType.emailAddress,
            decoration: textFieldDecoration.copyWith(
              labelText: "Mail ID",
              labelStyle: OTextStyle.bodyXSmall.copyWith(color: Themes.permanentTextColor),
            ),
          ),
          const SizedBox(height: 18),
          CheckboxListTile(
            value: checkAdmin,
            title: Text('Admin', style: OTextStyle.bodySmall.copyWith(color: Themes.white)),
            onChanged: (bool? value) {
              setState(() {
                checkAdmin = value!;
              });
            },
          ),
          const SizedBox(height: 18),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Themes.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: InkWell(
              onTap: () async {
                if (_formkey.currentState!.validate() == false) {
                  return;
                } else {
                  if (!apiCall) {
                    setState(() {
                      apiCall = true;
                    });
                    List<String> x =
                        checkAdmin
                            ? List<String>.of(rd.currentRoom.owner)
                            : List<String>.of(rd.currentRoom.allowedUsers);
                    x.add(emailCtl.text);
                    String s = checkAdmin ? "owner" : "allowedUsers";
                    var details = jsonEncode({s: x});

                    try {
                      var res = await APIService().editRoomDetails(rd.currentRoom.id, details);
                      // print(res);
                      rd.updateRoom(res);
                      if (!mounted) return;
                      Navigator.pop(context);
                    } catch (e) {
                      setState(() {
                        apiCall = false;
                      });
                      // print("THIS WAS THE ERROR");
                      Fluttertoast.showToast(
                        msg: 'Email Invalid',
                        backgroundColor: Themes.white,
                        textColor: Themes.black,
                      );
                      // print(rd.currentRoom.owner);
                      // print(rd.currentRoom.allowedUsers);
                      Navigator.pop(context);
                    }
                  }
                }
              },
              child: Center(
                child:
                    (apiCall)
                        ? const CircularProgressIndicator()
                        : Text(
                          'Add',
                          style: OTextStyle.labelMedium.copyWith(color: Themes.onPrimaryColor),
                        ),
              ),
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
