import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/data_store.dart';
import '../../globals/styles.dart';
import 'package:lottie/lottie.dart';

import '../../models/room_model.dart';
import 'datepicker_color.dart';

class RequestModal extends StatefulWidget {
  final RoomModel room;
  const RequestModal({super.key,required this.room});

  @override
  State<RequestModal> createState() => _RequestModalState();
}

class _RequestModalState extends State<RequestModal>
    with SingleTickerProviderStateMixin {
  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();
  TextEditingController purposeCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  DateTime? pickedDate=null;
  TimeOfDay? res=null;
  TimeOfDay? res1=null;
  final _formkey = GlobalKey<FormState>();
  String time24to12Format(String time) {
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String send = "";
    if (h > 12) {
      var temp = h - 12;
      send =
          "0$temp:${m.toString().length == 1 ? "0" + m.toString() : m.toString()} " +
              "PM";
    } else {
      send =
          "$h:${m.toString().length == 1 ? "0" + m.toString() : m.toString()}  " +
              "AM";
    }

    return send;
  }

  Future<void> _showDialog(String details) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
            future: APIService().createBooking(details),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.hasError){
                return  SimpleDialog(
                  backgroundColor: Color.fromRGBO(39, 49, 65, 1),
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Error',
                        style: sentRequestStyle,
                      ),
                    ),
                  ],
                );
              }
              return SimpleDialog(
              backgroundColor: Color.fromRGBO(39, 49, 65, 1),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      )),
                ),
                Lottie.asset('packages/irbs/assets/sent_request.json',
                    height: 100),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Request Sent',
                    style: sentRequestStyle,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Cancel',
                      style: cancelButtonStyle,
                    ))
              ],
            );}
          );
        });
  }

  @override
  void initState() {
    super.initState();
    dateCtl.text = DateFormat.yMMMMd().format(DateTime.now());
    nameCtl.text = DataStore.userData["name"] ?? "Name";
    pickedDate=DateTime.now();
  }

  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color.fromRGBO(39, 49, 65, 1)),
        margin: EdgeInsets.fromLTRB(16, 0, 16, 24),
        padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.room.roomName,
                  style: roomNameTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose a date and time you want to book the room for.',
                  style: roomInstructTextSTyle,
                ),
              ),
              SizedBox(
                height: 16,
              ),
                  TextFormField(
                    controller: nameCtl,
                    readOnly: true,
                    style: permanentTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: labelTextStyle,
                      // prefixIconColor: Colors.white,
                      // prefixIcon: Icon(Icons.local_phone_outlined),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(147, 152, 160, 1))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(147, 152, 160, 1))),
                    ),
                  ),
                  SizedBox(
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
                  prefixIcon: ImageIcon(
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
                  if (pickedDate != Null) {
                    print(pickedDate);
                    print(pickedDate?.toIso8601String());
                    String formattedDate =
                        DateFormat.yMMMMd().format(pickedDate!);
                    setState(() {
                      dateCtl.text = formattedDate;
                    });
                  }
                },
              ),
              SizedBox(
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
                    prefixIcon: ImageIcon(
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
                            backgroundColor: Color.fromRGBO(39, 49, 65, 0.7));

                        setState(() {
                          text = '';
                        });
                      } else {
                        print(res);
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
                      print(text);
                      print(formattedTime);
                      if (formattedTime[0] == '0' &&
                          formattedTime[1].compareTo('8') < 0) {
                        print('Morning');
                        Fluttertoast.showToast(
                            msg:
                                'You cannot book after 12:00 AM and before 8:00 AM',
                            backgroundColor: Color.fromRGBO(39, 49, 65, 0.7));
                        setState(() {
                          text = '';
                          timeCtl.text = '';
                          res1=null;
                          res=null;
                        });
                      } else if (formattedTime.compareTo(text) < 0) {
                        Fluttertoast.showToast(
                            msg: 'Please Enter a Valid Time Range',
                            backgroundColor: Color.fromRGBO(39, 49, 65, 0.7));
                        setState(() {
                          timeCtl.text = '';
                          res=null;
                          res1=null;
                        });
                        print('To time should be after From time');
                      } else {
                        print(res1);
                        setState(() {
                          timeCtl.text =
                              "${time24to12Format(text)} - ${time24to12Format(formattedTime)}";
                        });
                      }
                    }
                  }),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'State the purpose of your booking',
                  style: labelTextStyle,
                ),
              ),
              SizedBox(
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
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate() == false) {
                      print('invalid');
                    } else {
                      var inTime=new DateTime(pickedDate!.year,pickedDate!.month,pickedDate!.day,res!.hour,res!.minute);
                      print(inTime);
                      var outTime=new DateTime(pickedDate!.year,pickedDate!.month,pickedDate!.day,res1!.hour,res1!.minute);
                      print(outTime);
                      print(nameCtl.text);
                      print(dateCtl.text);
                      print(timeCtl.text);
                      print(purposeCtl.text);
                      print(inTime);
                      print(inTime.toIso8601String());
                      var details=jsonEncode({
                        "roomId": widget.room.id.toString(),
                        "inTime": inTime.toIso8601String(),
                        "outTime": outTime.toIso8601String(),
                        "bookingPurpose": purposeCtl.text
                      });
                      Navigator.pop(context);
                      _showDialog(details);
                    }
                  },
                  child: Container(
                    height: 36,
                    width: 136,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
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
