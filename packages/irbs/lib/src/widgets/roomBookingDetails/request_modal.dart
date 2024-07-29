import 'dart:convert';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/functions/format_time.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:provider/provider.dart';

import '../../globals/colors.dart';

import '../../globals/styles.dart';
import '../../models/room_model.dart';
import '../../services/api.dart';
import '../../store/data_store.dart';
import '../../store/room_detail_store.dart';
import '../roomBookingDetails/booking_success_dailogue.dart';
import 'datepicker_color.dart';

class RequestModal extends StatefulWidget {
  final RoomModel room;
  final BuildContext rootContext;

  const RequestModal({super.key, required this.room, required this.rootContext});

  @override
  State<RequestModal> createState() => _RequestModalState();
}

class _RequestModalState extends State<RequestModal> with SingleTickerProviderStateMixin {
  TextEditingController dateCtl = TextEditingController();
  TextEditingController fromTimeCtl = TextEditingController();
  TextEditingController toTimeCtl = TextEditingController();
  TextEditingController purposeCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  DateTime? pickedDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateCtl.text = DateFormat.yMMMMd().format(DateTime.now());
    nameCtl.text = DataStore.userData["name"] ?? "Name";
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(4), color: Themes.tileColor),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.room.roomName,
                    style: OnestopFonts.w700.size(16).setColor(Themes.white).setHeight(1.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose a date and time you want to book the room for.',
                    style: OnestopFonts.w400.size(10).setColor(Themes.white.withOpacity(0.6)),
                  ),
                ),
                const SizedBox(height: 16),
                _buildNameField(),
                const SizedBox(height: 12),
                _buildDatePicker(context),
                const SizedBox(height: 12),
                _buildTimePickers(context),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'State the purpose of your booking',
                    style: OnestopFonts.w400
                        .size(12)
                        .letterSpace(0.4)
                        .setHeight(1.33)
                        .setColor(Themes.permanentTextColor),
                  ),
                ),
                const SizedBox(height: 8),
                _buildPurposeField(),
                const SizedBox(height: 16),
                _buildSendRequestButton(context),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextFormField _buildPurposeField() {
    return TextFormField(
        controller: purposeCtl,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter the Purpose of your booking';
          }
          return null;
        },
        maxLines: 3,
        keyboardType: TextInputType.multiline,
        style: OnestopFonts.w500.size(14).setColor(Themes.white),
        decoration: textFieldDecoration.copyWith(
            hintText: 'Type here...',
            hintStyle: OnestopFonts.w400.size(12).setColor(Themes.comet)));
  }

  TextFormField _buildNameField() {
    return TextFormField(
      controller: nameCtl,
      readOnly: true,
      style: OnestopFonts.w500.size(14).setColor(Themes.permanentTextColor),
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: OnestopFonts.w400
            .size(12)
            .letterSpace(0.4)
            .setHeight(1.33)
            .setColor(Themes.permanentTextColor),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Themes.modalBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Themes.modalBorderColor)),
      ),
    );
  }

  Align _buildSendRequestButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          final check = _formKey.currentState!.validate();
          if (!check) return;
          if (isLoading) return;
          var inTime = DateTime(pickedDate!.year, pickedDate!.month, pickedDate!.day,
              fromTime!.hour, fromTime!.minute);
          var outTime = DateTime(
              pickedDate!.year, pickedDate!.month, pickedDate!.day, toTime!.hour, toTime!.minute);
          if (inTime.isBefore(DateTime.now())) {
            Fluttertoast.showToast(
                msg: "Start time has passed",
                backgroundColor: Themes.white,
                textColor: Themes.black);
            return;
          }
          var details = jsonEncode({
            "roomId": widget.room.id.toString(),
            "inTime": inTime.toIso8601String(),
            "outTime": outTime.toIso8601String(),
            "bookingPurpose": purposeCtl.text
          });
          setState(() {
            isLoading = true;
          });
          var response = await APIService().createBooking(details);
          if (response == "Success") {
            if (!mounted) return;
            var x = widget.rootContext.read<RoomDetailStore>();
            await x.setUpcomingBookings();
            if (!mounted) return;
            showDialogue(context);
          } else {
            setState(() {
              isLoading = false;
            });
            if (response ==
                'DioException [bad response]: The request returned an invalid status code of 400.') {
              Fluttertoast.showToast(
                  msg: "Slot already booked",
                  backgroundColor: Themes.white,
                  textColor: Themes.black);
            } else {
              Fluttertoast.showToast(
                  msg: "Some error occured, try again later",
                  backgroundColor: Themes.white,
                  textColor: Themes.black);
            }
          }
          if (!mounted) return;
          Navigator.pop(context);
        },
        child: Container(
          height: 36,
          width: 136,
          decoration: BoxDecoration(
            color: Themes.primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: Themes.white),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'Send Request',
                    style: OnestopFonts.w500.size(14).setColor(Themes.onPrimaryColor),
                  ),
                ),
        ),
      ),
    );
  }

  Row _buildTimePickers(BuildContext context) {
    return Row(
      children: [
        _buildFromTimePicker(context),
        const SizedBox(width: 16),
        _buildToTimePicker(context),
      ],
    );
  }

  Expanded _buildToTimePicker(BuildContext context) {
    return Expanded(
      child: TextFormField(
          controller: toTimeCtl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter To-Time';
            }
            return null;
          },
          style: OnestopFonts.w500.size(14).setColor(Themes.white),
          decoration: textFieldDecoration.copyWith(
            labelText: 'To',
            labelStyle: OnestopFonts.w400
                .size(12)
                .letterSpace(0.4)
                .setHeight(1.33)
                .setColor(Themes.permanentTextColor),
            prefixIconColor: Themes.white,
            prefixIcon: const ImageIcon(
              AssetImage('packages/irbs/assets/images/clock_icon.png'),
              color: Themes.white,
            ),
          ),
          readOnly: true,
          onTap: () async {
            if (fromTime == null) {
              Fluttertoast.showToast(
                  msg: 'From Time not selected!', backgroundColor: Themes.modalToastBgColor);
              return;
            }
            toTime = await showTimePicker(
              context: context,
              initialTime: fromTime!,
              helpText: 'SELECT TO TIME',
              // routeSettings: RouteSettings(),
              builder: (context, child) => IRBSDatePicker(
                child: child,
              ),
            );

            print(toTime.toString());

            if (toTime != null) {
              if (fromTime!.getTotalMinutes >= toTime!.getTotalMinutes) {
                Fluttertoast.showToast(
                    msg: 'Please Enter a Valid Time Range',
                    backgroundColor: Themes.modalToastBgColor);
                setState(() {
                  toTimeCtl.text = '';
                  toTime = null;
                });
              } else {
                toTimeCtl.text = formatTimeOfDay(toTime!);
              }
            }
          }),
    );
  }

  Expanded _buildFromTimePicker(BuildContext context) {
    return Expanded(
      child: TextFormField(
          controller: fromTimeCtl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter From-Time';
            }
            return null;
          },
          style: OnestopFonts.w500.size(14).setColor(Themes.white),
          decoration: textFieldDecoration.copyWith(
            labelText: 'From',
            labelStyle: OnestopFonts.w400
                .size(12)
                .letterSpace(0.4)
                .setHeight(1.33)
                .setColor(Themes.permanentTextColor),
            prefixIconColor: Themes.white,
            prefixIcon: const ImageIcon(
              AssetImage('packages/irbs/assets/images/clock_icon.png'),
              color: Themes.white,
            ),
          ),
          readOnly: true,
          onTap: () async {
            fromTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: 'SELECT FROM TIME',
              builder: (context, child) => IRBSDatePicker(
                child: child,
              ),
            );

            print(fromTime.toString());

            if (fromTime != null) {
              if (fromTime!.getTotalMinutes < 480) {
                setState(() {
                  fromTimeCtl.text = '';
                  fromTime = null;
                });
                Fluttertoast.showToast(
                    msg: 'You cannot book between 12:00 AM and 8:00 AM',
                    backgroundColor: Themes.modalToastBgColor);
              } else {
                fromTimeCtl.text = formatTimeOfDay(fromTime!);
              }
            }
          }),
    );
  }

  TextFormField _buildDatePicker(BuildContext context) {
    return TextFormField(
      controller: dateCtl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter date';
        }
        return null;
      },
      style: OnestopFonts.w500.size(14).setColor(Themes.white),
      decoration: textFieldDecoration.copyWith(
        labelText: 'Date',
        labelStyle: OnestopFonts.w400
            .size(12)
            .letterSpace(0.4)
            .setHeight(1.33)
            .setColor(Themes.permanentTextColor),
        prefixIconColor: Themes.white,
        prefixIcon: const ImageIcon(
          AssetImage('packages/irbs/assets/images/calender_icon.png'),
          color: Themes.white,
        ),
      ),
      readOnly: true,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2026),
            builder: (context, child) => IRBSDatePicker(
                  child: child,
                ));
        if (pickedDate != null) {
          String formattedDate = DateFormat.yMMMMd().format(pickedDate!);
          setState(() {
            dateCtl.text = formattedDate;
          });
        }
      },
    );
  }
}
