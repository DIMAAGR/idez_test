import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme {
  static final AppColors lightColors = AppColors.light();
  static final AppColors darkColors = AppColors.dark();

  static final AppTextStyles lightText = AppTextStyles(lightColors);
  static final AppTextStyles darkText = AppTextStyles(darkColors);

  static ThemeData get light {
    final c = lightColors;
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: c.blue,
        brightness: Brightness.light,
        background: Colors.white,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: c.lightGrey),
      popupMenuTheme: PopupMenuThemeData(color: Colors.white, textStyle: lightText.body1Regular),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: c.blue,
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.blue : Colors.white,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? Colors.white : c.grey,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.blue : c.grey,
        ),
      ),
    );
  }

  static ThemeData get dark {
    final c = darkColors;
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.light().black,
      colorScheme: ColorScheme.fromSeed(
        seedColor: c.blue,
        brightness: Brightness.dark,
        background: const Color(0xFF0E0E0E),
        surface: c.lightGrey,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.light().black,
        shadowColor: Colors.transparent,
        surfaceTintColor: c.lightGrey,
        foregroundColor: c.black,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: c.lightGrey),
      popupMenuTheme: PopupMenuThemeData(color: c.lightGrey, textStyle: darkText.body1Regular),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: c.blue,
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.blue : c.lightGrey,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? Colors.white : c.grey,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.blue : c.grey,
        ),
      ),
    );
  }

  static AppThemeOf of(BuildContext context) => AppThemeOf(context);
}

class AppThemeOf {
  final BuildContext context;
  AppThemeOf(this.context);

  AppColors get colors {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppTheme.darkColors : AppTheme.lightColors;
  }

  AppTextStyles get textStyles {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppTheme.darkText : AppTheme.lightText;
  }
}
