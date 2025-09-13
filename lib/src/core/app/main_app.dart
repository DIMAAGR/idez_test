import 'package:flutter/material.dart';
import 'package:idez_test/src/core/router/app_router.dart';
import 'package:idez_test/src/core/router/app_routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idez Todo App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: buildRouter(),
    );
  }
}
