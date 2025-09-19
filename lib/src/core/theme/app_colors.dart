import 'package:flutter/widgets.dart';

class AppColors {
  final Color black;
  final Color darkGrey;
  final Color grey;
  final Color lightGrey;

  final Color blue;
  final Color lightBlue;

  final Color orange;
  final Color lightOrange;

  final Color red;
  final Color lightRed;

  final Color green;
  final Color purple;

  const AppColors({
    required this.black,
    required this.darkGrey,
    required this.grey,
    required this.lightGrey,
    required this.blue,
    required this.lightBlue,
    required this.orange,
    required this.lightOrange,
    required this.red,
    required this.lightRed,
    required this.green,
    required this.purple,
  });

  factory AppColors.light() => const AppColors(
    black: Color(0xFF222222),
    darkGrey: Color(0xFF828388),
    grey: Color(0xFF9E9E9E),
    lightGrey: Color(0xFFFAFAFA),
    blue: Color(0xFF2196F3),
    lightBlue: Color(0xFFE3F2FD),
    orange: Color(0xFFFB8C00),
    lightOrange: Color(0xFFFFF3E0),
    red: Color(0xFFF44336),
    lightRed: Color(0xFFFFEBEE),
    green: Color(0xFF4CAF50),
    purple: Color(0xFF9C27B0),
  );

  factory AppColors.dark() => const AppColors(
    black: Color(0xFFF5F5F5),
    darkGrey: Color(0xFFBDBDBD),
    grey: Color(0xFF9E9E9E),
    lightGrey: Color(0xFF121212),
    blue: Color(0xFF2196F3),
    lightBlue: Color(0xFF0D47A1),
    orange: Color(0xFFFB8C00),
    lightOrange: Color(0xFF3E2723),
    red: Color(0xFFF44336),
    lightRed: Color(0xFF3B1111),
    green: Color(0xFF4CAF50),
    purple: Color(0xFF9C27B0),
  );
}
