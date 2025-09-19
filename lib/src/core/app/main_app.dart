import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../modules/shared/domain/enums/selected_theme_enum.dart';
import '../router/app_router.dart';
import '../router/app_routes.dart';
import '../services/settings/settings_service.dart';
import '../theme/app_theme.dart';

class MainApp extends StatelessWidget {
  final SettingsService settingsService;
  const MainApp({super.key, required this.settingsService});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return MaterialApp(
          title: 'Idez Todo App',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.home,
          routes: buildRouter(),
          onGenerateRoute: buildOnGenerateRoute,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _mapThemeMode(settingsService.themeMode),
        );
      },
    );
  }

  // Outros Themes podem vim com outras cores
  ThemeMode _mapThemeMode(SelectedTheme selected) {
    switch (selected) {
      case SelectedTheme.light:
        return ThemeMode.light;
      case SelectedTheme.dark:
        return ThemeMode.dark;
      case SelectedTheme.system:
        return ThemeMode.system;
    }
  }
}
