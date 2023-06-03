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

const kRejectStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);

const kApproveStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
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