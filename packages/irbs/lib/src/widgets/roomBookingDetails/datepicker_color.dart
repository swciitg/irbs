import 'package:flutter/material.dart';
import '../../globals/styles.dart';

class IRBSDatePicker extends StatefulWidget {
  final Widget? child;
  const IRBSDatePicker({super.key, this.child});

  @override
  State<IRBSDatePicker> createState() => _IRBSDatePickerState();
}

class _IRBSDatePickerState extends State<IRBSDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: const TextTheme(
          headlineMedium: basicFontStyle,
          headlineSmall: basicFontStyle, // Selected Date landscape
          titleLarge: basicFontStyle, // Selected Date portrait
          labelSmall: basicFontStyle, // Title - SELECT DATE
          bodyLarge: basicFontStyle, // year gridbview picker
          titleMedium: basicFontStyle, // input
          titleSmall: basicFontStyle, // month/year picker
          bodySmall: basicFontStyle, // days
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(189, 199, 220, 1),
          surface: Color.fromRGBO(43, 62, 92, 1),
        ),
        dialogBackgroundColor: const Color.fromRGBO(43, 62, 92, 1),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(43, 62, 92, 1), // button
              foregroundColor: const Color.fromRGBO(118, 172, 255, 1),
              elevation: 0,
              textStyle: basicFontStyle),
        ),
      ),
      child: widget.child!,
    );
  }
}
