import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/widgets/myroom/dropdown.dart';

class AddNewMember extends StatefulWidget {
  const AddNewMember({super.key});

  @override
  State<AddNewMember> createState() => _AddNewMemberState();
}

class _AddNewMemberState extends State<AddNewMember> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();


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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24,),
              SizedBox(
                height: 24,
                child: Text(
                  'Fill in the details',
                  style: appBarStyle.copyWith(
                    color: Themes.myRoomsFormHeadingColor
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 18,),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        cursorColor: Themes.cursorColor,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: textInputDecoration.copyWith(hintText: 'Name*'),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        cursorColor: Themes.cursorColor,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textInputDecoration.copyWith(hintText: 'Mail id*'),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        cursorColor: Themes.cursorColor,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: textInputDecoration.copyWith(hintText: 'Phone no.*'),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      height: 44,
                      child: CustomDropdown( 
                        onChange: (int i){
                          setState(() {
                            selected = designationList[i];
                          });
                        },
                        dropdownStyle: DropdownStyle(
                          width: 328,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          ),
                          color: Themes.dropDownColor,
                        ),
                        hideIcon: true,
                        items: designationList.map(
                          (designation) => DropdownItem(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Themes.dropDownColor,
                                border: Border(bottom: BorderSide(width: 0.5, color: Themes.regentGrey))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                child: SizedBox(
                                  height: 24,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      designation,
                                      style: permanentTextStyle,
                                    ),
                                  ),
                                ),
                              )
                            )
                          )).toList(),
                        child: Container(
                          width: 328,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Themes.tileColor
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 24,
                            child: Text(
                              selected ?? 'Select Designation',
                              style: permanentTextStyle,
                            ),
                          ),
                        ), 
                      )
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 20,
                      child: Text(
                        'Permission granted from',
                        style: roomheadingStyle.copyWith(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Themes.tileColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){},
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Image.asset('assets/images/calendar.png', package: 'irbs',)
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Container(
                                height: 24,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                                  style: permanentTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 20,
                      child: Text(
                        'Permission valid till',
                        style: roomheadingStyle.copyWith(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Themes.tileColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){},
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Image.asset('assets/images/calendar.png', package: 'irbs',)
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Container(
                                height: 24,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                                  style: permanentTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 164,),
                    SizedBox(
                      height: 48,
                      width: 328,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: elevatedButtonStyle,
                        child: const Text('+ Add Member', style: elevatedButtonTextStyle,),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}