import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/widgets/roomdetails/datepicker_color.dart';
import '../../globals/styles.dart';
import 'package:lottie/lottie.dart';

class RequestModal extends StatefulWidget {
  const RequestModal({super.key});

  @override
  State<RequestModal> createState() => _RequestModalState();
}

class _RequestModalState extends State<RequestModal>
    with SingleTickerProviderStateMixin {
  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();
  TextEditingController contactCtl = TextEditingController();
  TextEditingController purposeCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController designationCtl = TextEditingController();
  bool isExpanded = false;
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

  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Color.fromRGBO(39, 49, 65, 1),
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
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
          );
        });
  }

  @override
  void initState() {
    super.initState();
    dateCtl.text = DateFormat.yMMMMd().format(DateTime.now());
    nameCtl.text = 'NandRaj Mahendaraj';
    designationCtl.text = 'Design Head Coding Club';
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
              // SizedBox(
              //   height: 26,
              // ),
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Container(
                  height: 22,
                  child: Center(
                    child: isExpanded
                        ? ImageIcon(
                            AssetImage(
                                'packages/irbs/assets/images/collapse_modal.png'),
                            color: Color.fromRGBO(147, 152, 160, 1),
                          )
                        : Container(
                            height: 2,
                            width: 72,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(147, 152, 160, 1),
                            ),
                          ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Yoga Room',
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
              Visibility(
                visible: isExpanded,
                child: Column(
                  children: [
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
                      controller: designationCtl,
                      readOnly: true,
                      style: permanentTextStyle,
                      decoration: InputDecoration(
                        labelText: 'Designation',
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
                    )
                  ],
                ),
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
                decoration: InputDecoration(
                    labelText: 'Date',
                    labelStyle: labelTextStyle,
                    prefixIconColor: Colors.white,
                    prefixIcon: ImageIcon(
                      AssetImage(
                          'packages/irbs/assets/images/calender_icon.png'),
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(147, 152, 160, 1))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(147, 152, 160, 1))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(color: Colors.red))),
                readOnly: true,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2024),
                      builder: (context, child) => CustomDatePicker(
                            child: child,
                          ));
                  if (pickedDate != Null) {
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
                  decoration: InputDecoration(
                      labelText: 'Time',
                      labelStyle: labelTextStyle,
                      prefixIconColor: Colors.white,
                      prefixIcon: ImageIcon(
                        AssetImage(
                            'packages/irbs/assets/images/clock_icon.png'),
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(147, 152, 160, 1))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(147, 152, 160, 1))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(color: Colors.red))),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? res = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      helpText: 'SELECT FROM TIME',
                      builder: (context, child) => CustomDatePicker(
                        child: child,
                      ),
                    );
                    if (res != Null) {
                      String formattedTime = res.toString().substring(10, 15);
                      setState(() {
                        timeCtl.text = formattedTime;
                      });
                    }
                    TimeOfDay? res1 = await showTimePicker(
                      context: context,
                      initialTime: res!,
                      helpText: 'SELECT TO TIME',
                      routeSettings: RouteSettings(),
                      builder: (context, child) => CustomDatePicker(
                        child: child,
                      ),
                    );
                    if (res1 != Null) {
                      String formattedTime = res1.toString().substring(10, 15);
                      if (formattedTime.compareTo(timeCtl.text) < 0) {
                        Fluttertoast.showToast(
                            msg: 'Please Enter a Valid Time Range',
                            backgroundColor: Color.fromRGBO(39, 49, 65, 0.7));
                        setState(() {
                          timeCtl.text = '';
                        });
                        print('To time should be after From time');
                      } else {
                        setState(() {
                          timeCtl.text =
                              "${time24to12Format(timeCtl.text)} - ${time24to12Format(formattedTime)}";
                        });
                      }
                    }
                  }),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: contactCtl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Contact Number';
                  }
                  if (value.length != 10) return 'Enter a Valid Contant Number';
                  return null;
                },
                style: TextFormFieldStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Contact Number',
                    labelStyle: labelTextStyle,
                    prefixIconColor: Colors.white,
                    prefixIcon: ImageIcon(
                      AssetImage('packages/irbs/assets/images/phone_icon.png'),
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(147, 152, 160, 1))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(147, 152, 160, 1))),
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
                decoration: InputDecoration(
                    hintText: 'Type here...',
                    hintStyle: hintTextStyle,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.5))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.5))),
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
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate() == false) {
                      print('invalid');
                    } else {
                      print(nameCtl.text);
                      print(designationCtl.text);
                      print(dateCtl.text);
                      print(timeCtl.text);
                      print(contactCtl.text);
                      print(purposeCtl.text);
                      Navigator.pop(context);
                      _showDialog();
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
    ;
  }
}
