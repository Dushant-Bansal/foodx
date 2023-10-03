import 'package:flutter/material.dart';
import 'package:food_x/styles/snack_bar.dart';
import '../../styles/palette.dart';

final double fontSize =
    MediaQuery.of(scaffoldMessengerKey.currentContext!).textScaleFactor;

TextStyle kPoppins = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 14 / fontSize,
);

TextStyle kPoppinsSmall = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 10.0 / fontSize,
);

TextStyle kPoppinsSmallBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: 10.0 / fontSize,
);

TextStyle kPoppinsWhite = TextStyle(
  fontFamily: 'Poppins',
  color: Palette.white,
  fontSize: 14 / fontSize,
);

TextStyle kPoppinsLight = TextStyle(
  fontFamily: 'Poppins-Light',
  fontSize: 14 / fontSize,
);

TextStyle kPoppinsLightBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  fontSize: 12.0 / fontSize,
);

TextStyle kPoppinsBold = TextStyle(
  fontFamily: 'Poppins-Bold',
  fontSize: 14 / fontSize,
);

TextStyle kPoppinsLightWhiteSmall = TextStyle(
  fontFamily: 'Poppins-Light',
  color: Palette.white,
  fontSize: 12.0 / fontSize,
);

TextStyle kPoppinsLightWhite = TextStyle(
  fontFamily: 'Poppins-Light',
  color: Palette.white,
  fontSize: 14 / fontSize,
);

TextStyle kPoppinsLightWhiteLarge = TextStyle(
  fontFamily: 'Poppins-Light',
  color: Palette.white,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.2,
  fontSize: 20.0 / fontSize,
);

TextStyle kPoppinsBoldWhiteSmall = TextStyle(
  fontFamily: 'Poppins-Bold',
  color: Palette.white,
  fontSize: 20.0 / fontSize,
);

TextStyle kPoppinsBoldWhite = TextStyle(
  fontFamily: 'Poppins-Bold',
  color: Palette.white,
  fontSize: 32.0 / fontSize,
  height: 1.2,
);
