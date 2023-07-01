import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/widgets/myrooms/dropdown.dart';
import 'package:irbs/src/widgets/roomdetails/datepicker_color.dart';

class MemberDetails extends StatefulWidget {
  final bool isEdit;

  const MemberDetails({required this.isEdit, super.key});

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  final List<String> designationList = [
    'Member',
    'Secretary',
    'Overall Coordinator',
    'Design Head',
    'Web Dev Head'
  ];
  String? selected;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double fieldWidth = screenWidth * 328 / 360;
    final double horizontalPadding = screenWidth * 16 / 360;

    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'IRBS',
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Themes.kCommonBoxBackground,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Form(
          child: Stack(fit: StackFit.expand, children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 24,
                    child: Text(
                      widget.isEdit ? 'Edit Details:' : 'Fill in the details',
                      style: appBarStyle.copyWith(
                          color: Themes.myRoomsFormHeadingColor),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    height: 44,
                    width: fieldWidth,
                    child: TextFormField(
                      style: editRoomText,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter Name';
                      //   }
                      //   return null;
                      // },
                      textCapitalization: TextCapitalization.words,
                      cursorColor: Themes.cursorColor,
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Name*'),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 44,
                    width: fieldWidth,
                    child: TextFormField(
                      style: editRoomText,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter Mail Id';
                      //   }
                      //   return null;
                      // },
                      cursorColor: Themes.cursorColor,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Mail id*'),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 44,
                    width: fieldWidth,
                    child: TextFormField(
                      style: editRoomText,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter Phone No.';
                      //   }
                      //   return null;
                      // },
                      cursorColor: Themes.cursorColor,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Phone no.*'),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                      height: 44,
                      width: fieldWidth,
                      child: CustomDropdown(
                        onChange: (int i) {
                          setState(() {
                            selected = designationList[i];
                          });
                        },
                        dropdownStyle: DropdownStyle(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          color: Themes.dropDownColor,
                        ),
                        hideIcon: true,
                        items: designationList
                            .map((designation) => DropdownItem(
                                child: Container(
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        color: Themes.dropDownColor,
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.5,
                                                color: Themes.regentGrey))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 8),
                                      child: SizedBox(
                                        height: 24,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            designation,
                                            style: editRoomText,
                                          ),
                                        ),
                                      ),
                                    ))))
                            .toList(),
                        child: Container(
                          height: 48,
                          width: fieldWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Themes.tileColor),
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding, vertical: 12),
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 24,
                            child: Text(
                              selected ?? 'Select Designation',
                              style: editRoomText,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      'Permission granted from',
                      style: roomheadingStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 48,
                    width: fieldWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Themes.tileColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: () async {
                            DateTime? d = await showDatePicker(
                              context: context,
                              initialDate: startDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                              builder: (context, child) => CustomDatePicker(
                                child: DatePickerDialog(
                                  initialDate: startDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                ),
                              ),
                            );

                            if (mounted) {
                              setState(() {
                                startDate = d ?? startDate;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Image.asset(
                                    'assets/images/calendar.png',
                                    package: 'irbs',
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 24,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateFormat('MMMM dd, yyyy').format(startDate),
                                  style: editRoomText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: horizontalPadding,
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      'Permission valid till',
                      style: roomheadingStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 48,
                    width: fieldWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Themes.tileColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: () async {
                            DateTime? d = await showDatePicker(
                              context: context,
                              initialDate: endDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                              builder: (context, child) => CustomDatePicker(
                                child: DatePickerDialog(
                                  initialDate: endDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                ),
                              ),
                            );

                            if (mounted) {
                              setState(() {
                                endDate = d ?? endDate;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Image.asset(
                                    'assets/images/calendar.png',
                                    package: 'irbs',
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 24,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateFormat('MMMM dd, yyyy').format(endDate),
                                  style: editRoomText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: horizontalPadding,
                  ),
                  SizedBox(
                    height: 24,
                    child: Center(
                      child: Text(
                        errorMessage,
                        style: permanentTextStyle.copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 108,
                  ),
                ],
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
                    color: const Color.fromRGBO(28, 28, 30, 1),
                    child: Container(
                      height: 48,
                      margin:  EdgeInsets.fromLTRB(0, 0, 0, screenWidth*0.1),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(118, 172, 255, 1),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: InkWell(
                          onTap: () {
                            if (_emailController.text.trim() != '' &&
                                _nameController.text.trim() != '' &&
                                _phoneController.text.trim() != '' &&
                                selected != null) {
                              print({
                                'name': _nameController.text.trim(),
                                'mailId': _emailController.text.trim(),
                                'phoneNo': _phoneController.text.trim(),
                                'designation': selected,
                                'startDate': startDate,
                                'endDate': endDate
                              });
                            } else {
                              setState(() {
                                errorMessage = 'All fields are required!';
                              });
                            }
                          },
                          child: Center(
                              child: Text(
                            widget.isEdit ? 'Save' : '+ Add Member',
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
        ),
      ),
    );
  }
}
