import 'package:flutter/material.dart';
import 'package:idez_test/src/core/app/main_app.dart';
import 'package:idez_test/src/core/di/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupInjector();
  runApp(const MainApp());
}
