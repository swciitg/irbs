import 'package:flutter/material.dart';
import '../../globals/styles.dart';

class CustomDatePicker extends StatefulWidget {
  final Widget? child;
  const CustomDatePicker({super.key, this.child});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: TextTheme(
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
        dialogBackgroundColor: Color.fromRGBO(43, 62, 92, 1),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(43, 62, 92, 1), // button
              foregroundColor: Color.fromRGBO(118, 172, 255, 1),
              elevation: 0,
              textStyle: basicFontStyle),
        ),
      ),
      child: widget.child!,
    );
  }
}
