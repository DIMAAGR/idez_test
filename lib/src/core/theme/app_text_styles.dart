import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:idez_test/src/core/theme/app_colors.dart';

class AppTextStyles {
  final AppColors _colors = AppColors();

  TextStyle get h5 => TextStyle(
    fontSize: 24,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: _colors.black,
  );

  TextStyle get h6 => TextStyle(
    fontSize: 20,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: _colors.black,
  );

  TextStyle get body1Regular => TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: _colors.black,
  );

  TextStyle get body1Bold => TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    color: _colors.black,
  );

  TextStyle get body2Regular => TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: _colors.black,
  );

  TextStyle get body2Bold => TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    color: _colors.black,
  );

  TextStyle get caption => TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: _colors.grey,
  );

  TextStyle get button => TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    color: _colors.black,
  );
}
