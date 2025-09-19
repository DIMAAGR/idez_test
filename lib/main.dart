import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:idez_test/src/core/app/main_app.dart';
import 'package:idez_test/src/core/di/injector.dart';
import 'package:idez_test/src/core/notifications/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'src/core/services/settings/settings_service.dart';
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  final timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  final prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  setupInjector();

  await initNotifications();

  await GetIt.I<SettingsService>().loadSettings();
  runApp(MainApp(settingsService: GetIt.I<SettingsService>()));
}
