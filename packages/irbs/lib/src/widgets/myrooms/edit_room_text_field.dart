import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';

class EditRoomTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  const EditRoomTextField({super.key, required this.title, required this.controller});

  @override
  State<EditRoomTextField> createState() => _EditRoomTextFieldState();
}

class _EditRoomTextFieldState extends State<EditRoomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text(
          "${widget.title}:",
           style: MyFonts.w500.size(16).setColor(Themes.myRoomsFormHeadingColor).setHeight(1.5).letterSpace(0.1),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter ${widget.title}';
            }
            return null;
          },
          maxLines: widget.title == "Instructions" ? 5 : 1,
          keyboardType: widget.title == "Room Capacity" ? TextInputType.number: widget.title == "Room Name" ? TextInputType.text : TextInputType.multiline,
          style: widget.title != "Instructions" ?
            MyFonts.w400.size(16).setColor(Themes.white).setHeight(1.5).letterSpace(0.1) :
            MyFonts.w400.size(12).setColor(Themes.white).setHeight(1.333),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
              filled: true,
              fillColor: Themes.tileColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                      color: Themes.tileColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                      color: Themes.tileColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(color: Themes.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(color: Themes.red))),
        ),
      ],
    );
  }
}
