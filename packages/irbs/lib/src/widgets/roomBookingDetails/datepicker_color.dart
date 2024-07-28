import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';
import '../../globals/colors.dart';

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
        textTheme: TextTheme(
          headlineMedium: OnestopFonts.w400,
          headlineSmall: OnestopFonts.w400, // Selected Date landscape
          titleLarge: OnestopFonts.w400, // Selected Date portrait
          labelSmall: OnestopFonts.w400, // Title - SELECT DATE
          bodyLarge: OnestopFonts.w400, // year gridbview picker
          titleMedium: OnestopFonts.w400, // input
          titleSmall: OnestopFonts.w400, // month/year picker
          bodySmall: OnestopFonts.w400, // days
        ),
        colorScheme: const ColorScheme.dark(
          primary: Themes.datePickerPrimaryColor,
          surface: Themes.datePickerSurfaceColor,
        ),
        dialogBackgroundColor: Themes.datePickerSurfaceColor,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Themes.datePickerSurfaceColor, // button
              foregroundColor: Themes.primaryColor,
              elevation: 0,
              textStyle: OnestopFonts.w400),
        ),
      ),
      child: widget.child!,
    );
  }
}
