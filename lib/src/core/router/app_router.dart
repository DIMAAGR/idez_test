import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:idez_test/src/core/router/app_routes.dart';

import '../../modules/home/presentation/view/home_view.dart';
import '../../modules/home/presentation/view_model/home_view_model.dart';

typedef RouterBuilder = Map<String, WidgetBuilder>;

RouterBuilder buildRouter() {
  final getIt = GetIt.instance;
  return {AppRoutes.home: (context) => HomeView(viewModel: getIt<HomeViewModel>())};
}
