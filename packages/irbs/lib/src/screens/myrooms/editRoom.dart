import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/data_store.dart';
import 'package:irbs/src/widgets/myrooms/designationTile.dart';

import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../room_details.dart';

class EditRoom extends StatefulWidget {
  RoomModel data;
  EditRoom({required this.data});

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  TextEditingController clubNameCtl = TextEditingController();
  TextEditingController capacityCtl = TextEditingController();
  TextEditingController instructionCtl = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool apiCall = false;
  @override
  void initState() {
    super.initState();
    clubNameCtl.text = widget.data.roomName;
    capacityCtl.text = widget.data.roomCapacity.toString();
    instructionCtl.text =
        widget.data.instructions == null ? '' : widget.data.instructions!;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "IRBS",
          style: kAppBarTextStyle,
        ),
        backgroundColor: Themes.kCommonBoxBackground,
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Club Name:",
                    style: editRoomHeading,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: clubNameCtl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Club Name';
                      }
                      return null;
                    },
                    style: editRoomText,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                        filled: true,
                        fillColor: Color.fromRGBO(39, 49, 65, 1),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(39, 49, 65, 1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(39, 49, 65, 1))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Room Capacity:",
                    style: editRoomHeading,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: capacityCtl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Club Capacity';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: editRoomText,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                        filled: true,
                        fillColor: Color.fromRGBO(39, 49, 65, 1),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(39, 49, 65, 1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(39, 49, 65, 1))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Instructions:",
                    style: editRoomHeading,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: instructionCtl,
                    style: editRoomInstrText,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 19, 16),
                        filled: true,
                        fillColor: Color.fromRGBO(39, 49, 65, 1),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(39, 49, 65, 1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(39, 49, 65, 1))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(children: [
              Container(
                height: 24,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromRGBO(28, 28, 30, 0),
                      Color.fromRGBO(28, 28, 30, 1)
                    ])),
              ),
              Container(
                color: Color.fromRGBO(28, 28, 30, 1),
                child: Container(
                  height: 52,
                  margin: const EdgeInsets.fromLTRB(17, 0, 16, 36),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: InkWell(
                      onTap: () async {
                        // Navigator.pushNamed(context, '/irbs/roomList');
                        if (!apiCall) {
                          if (_formkey.currentState!.validate() == false) {
                            print('invalid');
                          } else {
                            print(clubNameCtl.text);
                            print(capacityCtl.text);
                            print(instructionCtl.text);
                            var details = jsonEncode({
                              'roomName': clubNameCtl.text,
                              'roomCapacity': capacityCtl.text,
                              'instructions': instructionCtl.text
                            });
                            setState(() {
                              apiCall = true;
                            });
                            await APIService()
                                .editRoomDetails(widget.data.id, details)
                                .then((value) {
                              print(value);
                              DataStore.myRooms.removeWhere(
                                  (element) => element.id == value.id);
                              DataStore.myRooms.add(value);
                              if (DataStore.rooms[widget.data.roomType] !=
                                  null) {
                                DataStore.rooms[widget.data.roomType]!
                                    .removeWhere(
                                        (element) => element.id == value.id);
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
                        }
                      },
                      child: const Center(
                          child: Text(
                        'Save Details',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            package: 'irbs',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
              ),
            ])),
        if (apiCall)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (apiCall)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ]),
    );
  }
}
