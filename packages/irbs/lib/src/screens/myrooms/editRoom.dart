import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/myrooms/designationTile.dart';

import '../../globals/colors.dart';
import '../../globals/styles.dart';

class EditRoom extends StatefulWidget {
  var data;
  var designations;
  EditRoom({required this.data, required this.designations});

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  TextEditingController clubNameCtl = TextEditingController();
  TextEditingController capacityCtl = TextEditingController();
  TextEditingController instructionCtl = TextEditingController();
  @override
  void initState() {
    super.initState();
    clubNameCtl.text = widget.data["name"];
    capacityCtl.text = widget.data["capacity"];
    instructionCtl.text = widget.data["instructions"];
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
                  style: editRoomText,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                      filled: true,
                      fillColor: Color.fromRGBO(39, 49, 65, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(39, 49, 65, 1))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(39, 49, 65, 1))),
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
                  keyboardType: TextInputType.number,
                  style: editRoomText,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                      filled: true,
                      fillColor: Color.fromRGBO(39, 49, 65, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(39, 49, 65, 1))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(39, 49, 65, 1))),
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
                          borderSide:
                              BorderSide(color: Color.fromRGBO(39, 49, 65, 1))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(39, 49, 65, 1))),
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
                  "Designations",
                  style: editRoomHeading,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: Color.fromRGBO(85, 95, 113, 1), width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Color.fromRGBO(135, 145, 163, 1),
                        ),
                        Text(
                          'Add More',
                          style: addmoreStyle,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.designations.length,
                    itemBuilder: (BuildContext context, int index) {
                      String key = widget.designations.keys.elementAt(index);
                      return Column(
                        children: [
                          DesignationTile(
                              isAdmin: widget.designations[key], name: key),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      );
                    }),
                SizedBox(
                  height: 108,
                )
              ],
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
                      onTap: () {
                        // Navigator.pushNamed(context, '/irbs/roomList');
                        print(clubNameCtl.text);
                        print(capacityCtl.text);
                        print(instructionCtl.text);
                        Navigator.pop(context);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => MyRooms(
                        //       isAdmin: true,
                        //     ),
                        //   ),
                        // );
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
            ]))
      ]),
    );
  }
}
