import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:irbs/src/functions/snackbar.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/screens/room_details/edit_room_details.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/data_store.dart';
import 'package:irbs/src/widgets/myrooms/memberTile.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';

class RoomDetails extends StatefulWidget {
  final RoomModel room;
  const RoomDetails({super.key, required this.room});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  bool isAdmin = false;
  Future<void> addMemberDialog() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AddMember(room: widget.room);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAdmin = widget.room.owner.contains(DataStore.userData['outlookEmail']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    widget.room.roomName,
                    style: roomheadingStyle,
                  )),
                  if (isAdmin)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditRoomDetails(
                              data: widget.room,
                            ),
                          ),
                        );
                      },
                      child: const ImageIcon(
                        AssetImage('packages/irbs/assets/images/edit.png'),
                        color: Colors.white,
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Capacity: ${widget.room.roomCapacity}',
                  style: kRequestedRoomStyle,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Instructions',
                  style: instrHeadingStyle,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${widget.room.instructions}',
                  style: instrTextStyle,
                ),
              ),
              // const Align(
              //   alignment: Alignment.centerRight,
              //   child: Text(
              //     "See more",
              //     style: seemoreStyle,
              //   ),
              // ),
              const SizedBox(
                height: 16,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Members',
                  style: instrHeadingStyle,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              if (isAdmin)
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: const Color.fromRGBO(85, 95, 113, 1),
                          width: 1),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Color.fromRGBO(118, 172, 255, 1),
                        ),
                        Text(
                          'Add Member',
                          style: addmemberStyle,
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    await addMemberDialog();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const MemberDetails(isEdit: false),
                  },
                ),
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.room.owner.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MemberTile(
                          isAdmin: isAdmin,
                          index: index,
                          room: widget.room,
                          isPersonAdmin: true,
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    );
                  }),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.room.allowedUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        MemberTile(
                          isAdmin: isAdmin,
                          index: index,
                          room: widget.room,
                          isPersonAdmin: false,
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class AddMember extends StatefulWidget {
  RoomModel room;
  AddMember({super.key, required this.room});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  TextEditingController emailCtl = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool checkAdmin = true;
  late bool apiCall;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall = false;
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SimpleDialog(
        backgroundColor: Color.fromRGBO(39, 49, 65, 1),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )),
          ),
          SizedBox(
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
          SizedBox(
            height: 18,
          ),
          TextFormField(
              controller: emailCtl,
              validator: (value) {
                if (value == null || value == '') return 'Enter Email';
                if (!value.endsWith('@iitg.ac.in'))
                  return 'Email should be IITG Mail Id';
                if (widget.room.owner.contains(value) ||
                    widget.room.allowedUsers.contains(value))
                  return 'Already a Member';
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
                  print(checkAdmin);
                });
              }),
          SizedBox(
            height: 18,
          ),
          Container(
            height: 48,
            // margin: EdgeInsets.fromLTRB(0, 0, 0, screenWidth * 0.1),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(118, 172, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: InkWell(
                onTap: () async {
                  if (_formkey.currentState!.validate() == false) {
                    print('invalid');
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
                  }
                },
                child: Center(
                    child: (apiCall)
                        ? CircularProgressIndicator()
                        : Text(
                            'Add',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                package: 'irbs',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))),
          ),
          SizedBox(
            height: 18,
          )
        ],
      ),
    );
    ;
  }
}
