import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';
import '../../models/room_model.dart';
import '../../services/api.dart';
import '../../store/room_detail_store.dart';
import '../../widgets/myrooms/edit_room_text_field.dart';

class EditRoomScreen extends StatefulWidget {
  final RoomModel data;
  const EditRoomScreen({super.key, required this.data});

  @override
  State<EditRoomScreen> createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  TextEditingController roomNameCtl = TextEditingController();
  TextEditingController capacityCtl = TextEditingController();
  TextEditingController instructionCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool apiCall = false;
  @override
  void initState() {
    super.initState();
    roomNameCtl.text = widget.data.roomName;
    capacityCtl.text = widget.data.roomCapacity.toString();
    instructionCtl.text =
        widget.data.instructions == null ? '' : widget.data.instructions!;
  }

  @override
  Widget build(BuildContext context) {
    var rd = context.read<RoomDetailStore>();
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
            color: Themes.white,
          ),
        ),
        title: Text(
          "IRBS",
          // style: kAppBarTextStyle,
          style: MyFonts.w500.size(20).setColor(Themes.white),
        ),
        backgroundColor: Themes.tileColor,
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditRoomTextField(
                      title: 'Room Name', controller: roomNameCtl),
                  const SizedBox(
                    height: 16,
                  ),
                  EditRoomTextField(
                      title: 'Room Capacity', controller: capacityCtl),
                  const SizedBox(
                    height: 16,
                  ),
                  EditRoomTextField(
                      title: "Instructions", controller: instructionCtl),
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
                      Themes.gradientBackgroundColor,
                      Themes.backgroundColor
                    ])),
              ),
              Container(
                color: Themes.backgroundColor,
                child: Container(
                  height: 52,
                  margin: const EdgeInsets.fromLTRB(17, 0, 16, 36),
                  decoration: const BoxDecoration(
                      color: Themes.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: InkWell(
                      onTap: () async {
                        if (!apiCall) {
                          if (_formKey.currentState!.validate() == false) {
                            return;
                          } else {
                            var details = jsonEncode({
                              'roomName': roomNameCtl.text,
                              'roomCapacity': capacityCtl.text,
                              'instructions': instructionCtl.text
                            });
                            setState(() {
                              apiCall = true;
                            });
                            await APIService()
                                .editRoomDetails(widget.data.id, details)
                                .then((value) {
                              rd.updateRoom(value);
                              Navigator.pop(context);
                            }).catchError((error, stackTrace) {
                              showSnackBar(error.toString());
                              setState(() {
                                apiCall = false;
                              });
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
            child: ModalBarrier(dismissible: false, color: Themes.black),
          ),
        if (apiCall)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ]),
    );
  }
}
