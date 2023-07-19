import 'package:flutter/material.dart';
import '../../globals/styles.dart';

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
          style: editRoomHeading,
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
          style: widget.title != "Instructions" ? editRoomText : editRoomInstrText,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
              filled: true,
              fillColor: const Color.fromRGBO(39, 49, 65, 1),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(39, 49, 65, 1))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(39, 49, 65, 1))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(color: Colors.red))),
        ),
      ],
    );
  }
}
