import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';

class Themes {
  // Background & surface
  static Color get backgroundColor => OColor.gray100;
  static Color get gradientBackgroundColor => OColor.gray100;
  static Color get kBackground => OColor.gray100;
  static Color get tileColor => OColor.white;
  static Color get darkSlateGrey => OColor.white;
  static Color get kCommonBoxBackground => OColor.white;
  static Color get drawerBox => OColor.white;
  static Color get requestTile => OColor.white;
  static Color get calenderBgColor => OColor.white;
  static Color get dropDownColor => OColor.white;

  // Primary / accent
  static Color get primaryColor => OColor.green600;
  static Color get onPrimaryColor => OColor.white;
  static Color get cursorColor => OColor.green600;

  // Text colors
  static Color get white => OColor.gray800; // primary text
  static Color get black => OColor.white;
  static Color get grey => OColor.gray400;
  static Color get white60 => OColor.gray600;
  static Color get kSubHeading => OColor.gray600;
  static Color get regentGrey => OColor.gray600;
  static Color get subHeadingColor => OColor.gray600;
  static Color get blueGrey => OColor.gray400;
  static Color get comet => OColor.gray400;
  static Color get darkGrey => OColor.gray300;
  static Color get hintText => OColor.gray400;
  static Color get permanentTextColor => OColor.gray600;
  static Color get roomHeadingColor => OColor.gray800;
  static Color get myRoomsFormHeadingColor => OColor.gray800;
  static Color get kTextButtonColor => OColor.green600;
  static Color get iconColor => OColor.gray600;
  static Color get dialogSubRoomColor => OColor.gray600;
  static Color get reasonColor => OColor.gray100;

  // Status colors
  static Color get rejectedColor => OColor.red500;
  static Color get rejectedBooking => OColor.red600;
  static Color get approvedGreenColor => OColor.green600;
  static Color get approvedColor => OColor.green600;
  static Color get pendingColor => OColor.gray400;
  static Color get cancelButtonColor => OColor.red500;

  // Border & misc
  static Color get borderColor => OColor.gray200;
  static Color get modalBorderColor => OColor.gray300;
  static const transparent = Colors.transparent;
  static const transparentColor = Colors.transparent;
  static const red = Colors.red;
  static Color get starColor => OColor.red500;
  static Color get inactiveNavDotsColor => OColor.gray300;

  // Button states
  static Color get disabledButtonBackground => OColor.gray200;

  // Date pickers
  static Color get datePickerPrimaryColor => OColor.green600;
  static Color get datePickerSurfaceColor => OColor.gray100;

  // Toast
  static Color get modalToastBgColor => OColor.gray800;

  // Shimmer
  static Color get allRequestShimmerHighlight => OColor.gray100;
  static Color get allRequestShimmerBase => OColor.gray200;

  // Gradient
  static const backgroundColor0Opacity = Color.fromRGBO(244, 245, 245, 0);
}
