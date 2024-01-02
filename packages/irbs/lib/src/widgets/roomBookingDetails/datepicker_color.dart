import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';

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
          headlineMedium: MyFonts.w400,
          headlineSmall: MyFonts.w400, // Selected Date landscape
          titleLarge: MyFonts.w400, // Selected Date portrait
          labelSmall: MyFonts.w400, // Title - SELECT DATE
          bodyLarge: MyFonts.w400, // year gridbview picker
          titleMedium: MyFonts.w400, // input
          titleSmall: MyFonts.w400, // month/year picker
          bodySmall: MyFonts.w400, // days
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
              textStyle: MyFonts.w400),
        ),
      ),
      child: widget.child!,
    );
  }
}
