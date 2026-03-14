import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import '../../functions/snackbar.dart';
import '../../models/room_model.dart';
import '../../services/api.dart';
import '../../store/room_detail_store.dart';

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
    instructionCtl.text = widget.data.instructions ?? '';
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
      contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      filled: true,
      fillColor: OColor.white,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var rd = context.read<RoomDetailStore>();
    return Scaffold(
      backgroundColor: OColor.gray100,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(FluentIcons.arrow_left_24_regular, color: OColor.gray800),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "IRBS",
          style: OTextStyle.headingSmall.copyWith(color: OColor.gray800),
        ),
        backgroundColor: OColor.gray100,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Room Name', style: OTextStyle.bodySmall.copyWith(color: OColor.gray500)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: roomNameCtl,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter Room Name';
                        return null;
                      },
                      style: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
                      decoration: _inputDecoration('Room Name'),
                    ),
                    const SizedBox(height: 20),
                    Text('Room Capacity', style: OTextStyle.bodySmall.copyWith(color: OColor.gray500)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: capacityCtl,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter Room Capacity';
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      style: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
                      decoration: _inputDecoration('Room Capacity'),
                    ),
                    const SizedBox(height: 20),
                    Text('Instructions', style: OTextStyle.bodySmall.copyWith(color: OColor.gray500)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: instructionCtl,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter Instructions';
                        return null;
                      },
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      style: OTextStyle.bodySmall.copyWith(color: OColor.gray800),
                      decoration: _inputDecoration('Instructions'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: apiCall
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate() == false) return;
                          var details = jsonEncode({
                            'roomName': roomNameCtl.text,
                            'roomCapacity': capacityCtl.text,
                            'instructions': instructionCtl.text,
                          });
                          setState(() => apiCall = true);
                          await APIService()
                              .editRoomDetails(widget.data.id, details)
                              .then((value) {
                                rd.updateRoom(value);
                                Navigator.pop(context);
                              })
                              .catchError((error, stackTrace) {
                                showSnackBar(error.toString());
                                setState(() => apiCall = false);
                              });
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
                          'Save Details',
                          style: OTextStyle.labelMedium.copyWith(color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
