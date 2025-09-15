import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:idez_test/src/core/router/app_routes.dart';
import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';
import '../../modules/board/presentation/view/board_view.dart';
import '../../modules/board/presentation/view_model/board_view_model.dart';
import '../../modules/home/presentation/view/home_view.dart';
import '../../modules/home/presentation/view_model/home_view_model.dart';
import '../../modules/task/presentation/view/task_view.dart';
import '../../modules/task/presentation/view_model/task_view_model.dart';

typedef RouterBuilder = Map<String, WidgetBuilder>;

Route _slideUpRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondary, child) {
      final tween = Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
    opaque: true,
    fullscreenDialog: true,
  );
}

RouterBuilder buildRouter() {
  final getIt = GetIt.instance;
  return {AppRoutes.home: (context) => HomeView(viewModel: getIt<HomeViewModel>())};
}

Route<dynamic>? buildOnGenerateRoute(RouteSettings settings) {
  final getIt = GetIt.instance;

  switch (settings.name) {
    case AppRoutes.board:
      return _slideUpRoute(
        BoardView(viewModel: getIt<BoardViewModel>(), boardType: settings.arguments as String?),
      );
    case AppRoutes.createTask:
      return _slideUpRoute(TaskView(viewModel: getIt<TaskViewModel>(), isCreate: true));
    case AppRoutes.editTask:
      return _slideUpRoute(
        TaskView(
          viewModel: getIt<TaskViewModel>(),
          isCreate: false,
          task: settings.arguments as TaskEntity?,
        ),
      );
    default:
      return null;
  }
}
