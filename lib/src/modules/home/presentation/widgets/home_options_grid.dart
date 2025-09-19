import 'package:flutter/material.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';
import 'package:idez_test/src/modules/home/presentation/widgets/task_option_card.dart';

class HomeOptionsGrid extends StatelessWidget {
  final int tasksCount;
  final int categoriesCount;
  final int overdueTasksCount;
  final int pendingTasksCount;
  final bool isTaskLoading;
  final bool isCategoryLoading;

  final VoidCallback onTasksPressed;
  final VoidCallback onCategoriesPressed;
  final VoidCallback onOverdueTasksPressed;
  final VoidCallback onPendingTasksPressed;

  const HomeOptionsGrid({
    super.key,
    required this.tasksCount,
    required this.categoriesCount,
    required this.overdueTasksCount,
    required this.pendingTasksCount,
    required this.onTasksPressed,
    required this.onCategoriesPressed,
    required this.onOverdueTasksPressed,
    required this.onPendingTasksPressed,
    this.isTaskLoading = false,
    this.isCategoryLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16 / 10,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      children: [
        TaskOptionCard(
          isLoading: isTaskLoading,
          onTap: onTasksPressed,
          icon: Icons.list_rounded,
          iconColor: AppTheme.of(context).colors.blue,
          backgroundColor: AppTheme.of(context).colors.lightBlue,
          title: 'Tarefas',
          count: tasksCount,
        ),
        TaskOptionCard(
          isLoading: isTaskLoading,
          onTap: onPendingTasksPressed,
          icon: Icons.calendar_today_rounded,
          iconColor: AppTheme.of(context).colors.orange,
          backgroundColor: AppTheme.of(context).colors.lightOrange,
          title: 'Pendentes',
          count: pendingTasksCount,
        ),
        TaskOptionCard(
          isLoading: isTaskLoading,
          onTap: onOverdueTasksPressed,
          icon: Icons.alarm,
          iconColor: AppTheme.of(context).colors.red,
          backgroundColor: AppTheme.of(context).colors.lightRed,
          title: 'Atrasadas',
          count: overdueTasksCount,
        ),
        TaskOptionCard(
          isLoading: isCategoryLoading,
          onTap: onCategoriesPressed,
          icon: Icons.folder_open_rounded,
          iconColor: AppTheme.of(context).colors.grey,
          backgroundColor: AppTheme.of(context).colors.lightGrey,
          title: 'Categorias',
          count: categoriesCount,
        ),
      ],
    );
  }
}
