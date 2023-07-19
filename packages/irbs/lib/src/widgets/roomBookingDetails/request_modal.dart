import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:irbs/src/store/data_store.dart';
import 'package:irbs/src/widgets/roomBookingDetails/booking_success_dailogue.dart';
import 'package:provider/provider.dart';
import '../../functions/format_time.dart';
import '../../globals/styles.dart';
import '../../models/room_model.dart';
import 'datepicker_color.dart';

class RequestModal extends StatefulWidget {
  final RoomModel room;
  const RequestModal({super.key, required this.room});

  @override
  State<RequestModal> createState() => _RequestModalState();
}

class _RequestModalState extends State<RequestModal>
    with SingleTickerProviderStateMixin {
  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();
  TextEditingController purposeCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  DateTime? pickedDate;
  TimeOfDay? res;
  TimeOfDay? res1;
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
    return Wrap(children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromRGBO(39, 49, 65, 1)),
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
                  style: roomNameTextStyle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose a date and time you want to book the room for.',
                  style: roomInstructTextSTyle,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: nameCtl,
                readOnly: true,
                style: permanentTextStyle,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: labelTextStyle,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(147, 152, 160, 1))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(147, 152, 160, 1))),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: dateCtl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter date';
                  }
                  return null;
                },
                style: TextFormFieldStyle,
                decoration: textFieldDecoration.copyWith(
                  labelText: 'Date',
                  labelStyle: labelTextStyle,
                  prefixIconColor: Colors.white,
                  prefixIcon: const ImageIcon(
                    AssetImage('packages/irbs/assets/images/calender_icon.png'),
                    color: Colors.white,
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2024),
                      builder: (context, child) => IRBSDatePicker(
                            child: child,
                          ));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat.yMMMMd().format(pickedDate!);
                    setState(() {
                      dateCtl.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                  controller: timeCtl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter time';
                    }
                    return null;
                  },
                  style: TextFormFieldStyle,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Time',
                    labelStyle: labelTextStyle,
                    prefixIconColor: Colors.white,
                    prefixIcon: const ImageIcon(
                      AssetImage('packages/irbs/assets/images/clock_icon.png'),
                      color: Colors.white,
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    String text = '';
                    res = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      helpText: 'SELECT FROM TIME',
                      builder: (context, child) => IRBSDatePicker(
                        child: child,
                      ),
                    );
                    if (res != null) {
                      String formattedTime = res.toString().substring(10, 15);
                      if (formattedTime[0] == '0' &&
                          formattedTime[1].compareTo('8') < 0) {
                        Fluttertoast.showToast(
                            msg:
                                'You cannot book after 12:00 AM and before 8:00 AM',
                            backgroundColor:
                                const Color.fromRGBO(39, 49, 65, 0.7));

                        setState(() {
                          text = '';
                        });
                      } else {
                        setState(() {
                          text = formattedTime;
                        });
                      }
                    }
                    res1 = (text == '')
                        ? null
                        : await showTimePicker(
                            context: context,
                            initialTime: res!,
                            helpText: 'SELECT TO TIME',
                            // routeSettings: RouteSettings(),
                            builder: (context, child) => IRBSDatePicker(
                              child: child,
                            ),
                          );
                    if (res1 != null) {
                      String formattedTime = res1.toString().substring(10, 15);
                      if (formattedTime[0] == '0' &&
                          formattedTime[1].compareTo('8') < 0) {
                        Fluttertoast.showToast(
                            msg:
                                'You cannot book after 12:00 AM and before 8:00 AM',
                            backgroundColor:
                                const Color.fromRGBO(39, 49, 65, 0.7));
                        setState(() {
                          text = '';
                          timeCtl.text = '';
                          res1 = null;
                          res = null;
                        });
                      } else if (formattedTime.compareTo(text) <= 0) {
                        Fluttertoast.showToast(
                            msg: 'Please Enter a Valid Time Range',
                            backgroundColor:
                                const Color.fromRGBO(39, 49, 65, 0.7));
                        setState(() {
                          timeCtl.text = '';
                          res = null;
                          res1 = null;
                        });
                      } else {
                        setState(() {
                          timeCtl.text =
                              "${time24to12Format(text)} - ${time24to12Format(formattedTime)}";
                        });
                      }
                    }
                  }),
              const SizedBox(
                height: 16,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'State the purpose of your booking',
                  style: labelTextStyle,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  controller: purposeCtl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Purpose of your booking';
                    }
                    return null;
                  },
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  style: TextFormFieldStyle,
                  decoration: textFieldDecoration.copyWith(
                      hintText: 'Type here...', hintStyle: hintTextStyle)),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate() == false) {
                      return;
                    } else {
                      var inTime = DateTime(pickedDate!.year, pickedDate!.month,
                          pickedDate!.day, res!.hour, res!.minute);
                      var outTime = DateTime(
                          pickedDate!.year,
                          pickedDate!.month,
                          pickedDate!.day,
                          res1!.hour,
                          res1!.minute);

                      var details = jsonEncode({
                        "roomId": widget.room.id.toString(),
                        "inTime": inTime.toIso8601String(),
                        "outTime": outTime.toIso8601String(),
                        "bookingPurpose": purposeCtl.text
                      });

                      var response = await APIService().createBooking(details);
                      if (response == "Success") {
                        showDialogue(context);
                        var x = context.read<CommonStore>();
                        DataStore.upcomingFlag = false;
                        x.delete = x.delete + 1;
                      } else {
                        if (response ==
                            'DioException [bad response]: The request returned an invalid status code of 400.') {
                          Fluttertoast.showToast(msg: "Slot already booked");
                        } else {
                          Fluttertoast.showToast(
                              msg: "Some error occured, try again later");
                        }
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 36,
                    width: 136,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'Send Request',
                        style: sendRequestTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    ]);
  }
}
