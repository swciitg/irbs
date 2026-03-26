import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    var rd = widget.rootContext.read<RoomDetailStore>();
    return Dialog(
      backgroundColor: OColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Member',
                    style: OTextStyle.headingSmall.copyWith(color: OColor.gray800),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(FluentIcons.dismiss_24_regular, color: OColor.gray500),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Email', style: OTextStyle.bodySmall.copyWith(color: OColor.gray500)),
              const SizedBox(height: 8),
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
                style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'user@iitg.ac.in',
                  hintStyle: OTextStyle.bodySmall.copyWith(color: OColor.gray400),
                  contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  filled: true,
                  fillColor: OColor.gray100,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: OColor.gray200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: OColor.green600),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: OColor.red500),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: OColor.red500),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => setState(() => checkAdmin = !checkAdmin),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: checkAdmin ? OColor.green600 : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: checkAdmin ? OColor.green600 : OColor.gray300,
                          width: 2,
                        ),
                      ),
                      child: checkAdmin
                          ? Icon(FluentIcons.checkmark_16_filled, color: Colors.white, size: 14)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Add as Admin',
                      style: OTextStyle.bodySmall.copyWith(color: OColor.gray800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: apiCall
                      ? null
                      : () async {
                          if (_formkey.currentState!.validate() == false) return;
                          setState(() => apiCall = true);
                          List<String> x = checkAdmin
                              ? List<String>.of(rd.currentRoom.owner)
                              : List<String>.of(rd.currentRoom.allowedUsers);
                          x.add(emailCtl.text);
                          String s = checkAdmin ? "owner" : "allowedUsers";
                          var details = jsonEncode({s: x});

                          try {
                            var res = await APIService().editRoomDetails(rd.currentRoom.id, details);
                            rd.updateRoom(res);
                            if (!mounted) return;
                            Navigator.pop(context);
                          } catch (e) {
                            setState(() => apiCall = false);
                            Fluttertoast.showToast(
                              msg: 'Email Invalid',
                              backgroundColor: OColor.gray800,
                              textColor: Colors.white,
                            );
                            Navigator.pop(context);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OColor.green600,
                    disabledBackgroundColor: OColor.gray200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: apiCall
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Add',
                          style: OTextStyle.labelMedium.copyWith(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
