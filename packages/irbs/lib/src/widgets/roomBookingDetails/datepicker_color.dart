import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';
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
          headlineMedium: OTextStyle.bodySmall,
          headlineSmall: OTextStyle.bodySmall, // Selected Date landscape
          titleLarge: OTextStyle.bodySmall, // Selected Date portrait
          labelSmall: OTextStyle.bodySmall, // Title - SELECT DATE
          bodyLarge: OTextStyle.bodySmall, // year gridbview picker
          titleMedium: OTextStyle.bodySmall, // input
          titleSmall: OTextStyle.bodySmall, // month/year picker
          bodySmall: OTextStyle.bodySmall, // days
        ),
        colorScheme: ColorScheme.light(
          primary: Themes.datePickerPrimaryColor,
          surface: Themes.datePickerSurfaceColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Themes.datePickerSurfaceColor, // button
            foregroundColor: Themes.primaryColor,
            elevation: 0,
            textStyle: OTextStyle.bodySmall,
          ),
        ),
        dialogTheme: DialogThemeData(backgroundColor: Themes.datePickerSurfaceColor),
      ),
      child: widget.child!,
    );
  }
}
