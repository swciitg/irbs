import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';

import 'my_fonts.dart';

final elevatedButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  backgroundColor: MaterialStateProperty.all(Themes.primaryColor),
  foregroundColor: MaterialStateProperty.all(Themes.onPrimaryColor),
);

final textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Themes.tileColor,
  hintText: 'Name*',
  hintStyle: MyFonts.w400.size(14).setColor(Themes.kSubHeading).letterSpace(0.5),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 0,
      )),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 0,
      )),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 0,
      )),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 0,
      )),
);

var textFieldDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide:
            const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide:
            const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5))),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.red)));

final searchBarBorder = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.zero,
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  ),
  hintText: 'Search Keyword (name,position etc.)',
  hintStyle: MyFonts.w400.size(12).setColor(Themes.comet),
);
