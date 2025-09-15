import 'package:flutter/material.dart';
import 'package:idez_test/src/core/theme/app_colors.dart';
import 'package:idez_test/src/core/theme/app_text_styles.dart';

abstract class AppTheme {
  static AppColors colors = AppColors();
  static AppTextStyles textStyles = AppTextStyles();

  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        textStyle: AppTheme.textStyles.body1Regular,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.colors.blue,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.white,
      ),
    );
  }
}
