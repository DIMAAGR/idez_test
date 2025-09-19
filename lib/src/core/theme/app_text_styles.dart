import 'package:flutter/widgets.dart';
import 'app_colors.dart';

class AppTextStyles {
  final AppColors c;
  const AppTextStyles(this.c);

  TextStyle get h5 => TextStyle(
    fontSize: 24,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: c.black,
  );

  TextStyle get h6 => TextStyle(
    fontSize: 20,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: c.black,
  );

  TextStyle get h6medium => TextStyle(
    fontSize: 20,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    color: c.black,
  );

  TextStyle get body1Regular =>
      TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: c.black);

  TextStyle get body1Bold =>
      TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: c.black);

  TextStyle get body2Regular =>
      TextStyle(fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: c.black);

  TextStyle get body2Bold =>
      TextStyle(fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: c.black);

  TextStyle get subtitle1Medium =>
      TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w600, color: c.black);

  TextStyle get caption =>
      TextStyle(fontSize: 12, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: c.grey);

  TextStyle get button =>
      TextStyle(fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: c.black);
}
