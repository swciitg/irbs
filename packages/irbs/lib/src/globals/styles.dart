import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';

import 'my_colors.dart';

const headingStyle = TextStyle(
  color: Themes.white,
  fontSize: 28,
  fontFamily: 'Montserrat',
  package: 'irbs',
  fontWeight: FontWeight.bold
);

const textStyle = TextStyle(
  fontFamily: 'Montserrat',
  package: 'irbs',
  color: Themes.white,
  fontSize: 14, 
);

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
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    )
  ),
  backgroundColor: MaterialStateProperty.all(Themes.primaryColor),
  foregroundColor: MaterialStateProperty.all(Themes.onPrimaryColor),
);

const elevatedButtonTextStyle = TextStyle(
  fontFamily: 'Raleway',
  fontSize: 16,
  package: 'irbs',
  fontWeight: FontWeight.bold
);
const roomTypeStyle= TextStyle(
fontFamily: 'Montserrat',
fontWeight: FontWeight.w400,
fontSize: 14,
color: kGrey11
);