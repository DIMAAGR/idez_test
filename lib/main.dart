import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:idez_test/src/core/app/main_app.dart';
import 'package:idez_test/src/core/di/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  setupInjector();
  runApp(const MainApp());
}
