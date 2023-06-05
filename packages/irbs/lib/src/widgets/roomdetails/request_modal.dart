import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/widgets/roomdetails/datepicker_color.dart';

import '../../globals/styles.dart';

class RequestModal extends StatefulWidget {
  const RequestModal({super.key});

  @override
  State<RequestModal> createState() => _RequestModalState();
}

class _RequestModalState extends State<RequestModal> {
  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();
  TextEditingController contactCtl = TextEditingController();
  TextEditingController purposeCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController designationCtl = TextEditingController();
  bool isExpanded = false;
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
                  child: Icon(Icons.keyboard_arrow_down_outlined),
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
              style: TextFormFieldStyle,
              decoration: InputDecoration(
                labelText: 'Date',
                labelStyle: labelTextStyle,
                prefixIconColor: Colors.white,
                prefixIcon: Icon(Icons.calendar_month_outlined),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(147, 152, 160, 1))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(147, 152, 160, 1))),
              ),
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
              style: TextFormFieldStyle,
              decoration: InputDecoration(
                labelText: 'Time',
                labelStyle: labelTextStyle,
                prefixIconColor: Colors.white,
                prefixIcon: Icon(Icons.access_time_rounded),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(147, 152, 160, 1))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(147, 152, 160, 1))),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2024));
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
              controller: contactCtl,
              style: TextFormFieldStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                labelStyle: labelTextStyle,
                prefixIconColor: Colors.white,
                prefixIcon: Icon(Icons.local_phone_outlined),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(147, 152, 160, 1))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(147, 152, 160, 1))),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'State the purpose if your booking',
                style: labelTextStyle,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: purposeCtl,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              style: TextFormFieldStyle,
              decoration: InputDecoration(
                hintText: 'Type here...',
                hintStyle: hintTextStyle,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5))),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
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
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    ]);
    ;
  }
}
