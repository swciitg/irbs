import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';
import 'colors.dart';

final elevatedButtonStyle = ButtonStyle(
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(OCornerRadius.s)),
  ),
  backgroundColor: WidgetStateProperty.all(Themes.primaryColor),
  foregroundColor: WidgetStateProperty.all(OColor.white),
);

final textInputDecoration = InputDecoration(
  filled: true,
  fillColor: OColor.gray100,
  hintText: 'Name*',
  hintStyle: OTextStyle.bodySmall.copyWith(color: OColor.gray400),
  contentPadding: const EdgeInsets.symmetric(horizontal: OSpacing.m),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(OCornerRadius.s),
    borderSide: BorderSide(color: OColor.gray200, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(OCornerRadius.s),
    borderSide: BorderSide(color: OColor.green600, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(OCornerRadius.s),
    borderSide: BorderSide(color: OColor.gray200, width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(OCornerRadius.s),
    borderSide: BorderSide(color: OColor.red500, width: 1),
  ),
);

var textFieldDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(OCornerRadius.s),
    borderSide: BorderSide(color: OColor.gray200),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(OCornerRadius.s),
    borderSide: BorderSide(color: OColor.green600),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(OCornerRadius.s),
    borderSide: BorderSide(color: OColor.red500),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(OCornerRadius.s),
    borderSide: BorderSide(color: OColor.red500),
  ),
);

final searchBarBorder = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.zero,
  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
  hintText: 'Search rooms...',
  hintStyle: OTextStyle.bodyXSmall.copyWith(color: OColor.gray400),
);
