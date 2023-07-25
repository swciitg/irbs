import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';

const headingStyle = TextStyle(
    color: Themes.white,
    fontSize: 28,
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontWeight: FontWeight.bold);

const textStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  color: Themes.white,
  fontSize: 14,
);
const kBookingDetailStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);
const subHeadingStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    color: Color.fromRGBO(135, 145, 165, 1));

const textButtonStyle1 = TextStyle(
  fontSize: 12,
  fontFamily: 'Raleway',
  package: 'irbs',
  fontStyle: FontStyle.normal,
  color: Themes.white,
);

const textButtonStyle2 = TextStyle(
  fontSize: 12,
  fontFamily: 'Raleway',
  package: 'irbs',
  fontStyle: FontStyle.normal,
  color: Themes.blueGrey,
);

final elevatedButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  backgroundColor: MaterialStateProperty.all(Themes.primaryColor),
  foregroundColor: MaterialStateProperty.all(Themes.onPrimaryColor),
);

const elevatedButtonTextStyle = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 16,
    package: 'irbs',
    fontWeight: FontWeight.bold);

const kAppBarTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
  color: Colors.white,
);

const kRequestedRoomStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);

const kDialogRoomStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
  color: Colors.white,
);

const kDialogSubRoomStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  color: Color.fromRGBO(189, 199, 220, 1),
);

const kDialogTimeStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 11.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Color.fromRGBO(253, 252, 255, 1),
);

const kDialogPurposeStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 11.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Color.fromRGBO(162, 172, 192, 1),
);

const kDialogInstStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 11.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  color: Color.fromRGBO(162, 172, 192, 1),
);

const kDialogHintStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  color: Color.fromRGBO(85, 95, 113, 1),
);

const kSubHeadingStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14.0,
  // fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Themes.kSubHeading,
);

final kHeading3Style = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 10.0,
  // fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white.withOpacity(0.6),
);

const kHeading3DescStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 10.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);

const kRejectedStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Color.fromRGBO(179, 38, 30, 1),
);

const kLabelStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 8.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);

const kReasonStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 8.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Color.fromRGBO(218, 227, 249, 1),
);

const kTextButtonStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: Color.fromRGBO(88, 129, 191, 1),
    decoration: TextDecoration.underline);

const kApprovedStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Color.fromRGBO(83, 172, 75, 1),
);

const kPendingStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Color.fromRGBO(147, 144, 148, 1),
);

const kApproveStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
  color: Color.fromRGBO(0, 27, 62, 1),
);
const roomTypeStyle = TextStyle(
    package: 'irbs',
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Themes.regentGrey);
const appBarStyle = TextStyle(
    color: Themes.white,
    fontSize: 20,
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontWeight: FontWeight.w500);
const rejectTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);
const roomNameTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 16,
  fontWeight: FontWeight.bold,
  height: 1.5,
);

final roomInstructTextSTyle = TextStyle(
  color: Colors.white.withOpacity(0.6),
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 10,
  fontWeight: FontWeight.w400,
);
const labelTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    color: Color.fromRGBO(169, 173, 179, 1),
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.4,
    height: 1.33);
const permanentTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  color: Color.fromRGBO(169, 173, 179, 1),
  fontWeight: FontWeight.w500,
  fontSize: 14,
);
const TextFormFieldStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
const sendRequestTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  color: Color.fromRGBO(0, 27, 62, 1),
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
const basicFontStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
);
const hintTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    color: Color.fromRGBO(85, 95, 113, 1),
    fontSize: 12,
    fontWeight: FontWeight.w400);
const roomheadingStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    color: Color.fromRGBO(253, 252, 255, 1),
    fontWeight: FontWeight.w600,
    fontSize: 24);
const sentRequestStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
const cancelButtonStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  color: Color.fromRGBO(255, 111, 102, 1),
  fontSize: 12,
  fontWeight: FontWeight.w500,
);
const rejectedStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14,
  color: Color.fromRGBO(217, 114, 108, 1),
  fontWeight: FontWeight.w500,
);
const pendingStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14,
  color: Color.fromRGBO(147, 144, 148, 1),
  fontWeight: FontWeight.w500,
);
const approvedStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14,
  color: Color.fromRGBO(53, 118, 42, 1),
  fontWeight: FontWeight.w500,
);

final textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Themes.tileColor,
  hintText: 'Name*',
  hintStyle: kSubHeadingStyle,
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
const instrHeadingStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Color.fromRGBO(135, 145, 165, 1),
);
const instrTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(253, 252, 255, 1),
    height: 1.4545);
const seemoreStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(118, 172, 255, 1),
);
const addmemberStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(118, 172, 255, 1),
);
const designationStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.2,
    letterSpacing: 0.1);
const popupMenuStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.219,
    letterSpacing: 0.1);
const dialogCancelStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.666,
    letterSpacing: 0.1);
const dialogConfirmStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(0, 27, 62, 1),
    height: 1.666,
    letterSpacing: 0.1);
const editRoomHeading = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(253, 252, 255, 1),
    height: 1.5,
    letterSpacing: 0.1);
const editRoomText = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.5,
    letterSpacing: 0.1);
const editRoomInstrText = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.white,
  height: 1.333,
);
const adminTileText = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Color.fromRGBO(255, 255, 255, 0.5),
  height: 1.333,
);
const addmoreStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(135, 145, 163, 1),
);
var textFieldDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5))),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Colors.red)));
const sideDrawerStyle = TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.715,
    letterSpacing: 0.1);
const sideDrawerRoomStyle=TextStyle(
    fontFamily: 'Montserrat',
    package: 'irbs',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.333,
    letterSpacing: 0.1);
