import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/modules/home/presentation/view_model/home_view_model.dart';
import 'package:idez_test/src/modules/home/presentation/widgets/home_title.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/fade_in.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/task_tile.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../widgets/home_options_grid.dart';

class HomeTab extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 32, 16.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeIn(
                delay: const Duration(milliseconds: 200),
                child: HomeTitle(onSettingsPressed: () {}),
              ),
              SizedBox(height: 24),
              FadeIn(
                delay: const Duration(milliseconds: 300),
                child: Observer(
                  builder: (context) {
                    return HomeOptionsGrid(
                      tasksCount: viewModel.tasks.length,
                      categoriesCount: viewModel.categoriesCount,
                      overdueTasksCount: viewModel.overdueTasksCount,
                      pendingTasksCount: viewModel.pendingTasksCount,
                      onTasksPressed: () {},
                      onCategoriesPressed: () {},
                      onOverdueTasksPressed: () {},
                      onPendingTasksPressed: () {},
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              FadeIn(
                delay: const Duration(milliseconds: 400),
                child: Text('Recentes', style: AppTheme.textStyles.body1Bold),
              ),
              SizedBox(height: 16),

              Observer(
                builder: (context) {
                  return ListView.separated(
                    cacheExtent: 0,
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: viewModel.tasks.length,
                    separatorBuilder: (context, index) => FadeIn(
                      delay: Duration(milliseconds: 500 + index * 100),
                      child: Divider(color: AppTheme.colors.grey.withAlpha(70)),
                    ),
                    itemBuilder: (context, index) {
                      return FadeIn(
                        delay: Duration(milliseconds: 500 + index * 100),
                        child: Observer(
                          builder: (context) {
                            final t = viewModel.tasks[index];

                            final selected = viewModel.selectedTasksIDs.contains(t.id);
                            final isSelectionMode = viewModel.isSelectionMode;
                            return TaskTile(
                              id: t.id,
                              title: t.title,
                              date: t.dueDate,
                              isCompleted: t.done,
                              category: t.categoryId ?? 'nenhuma',
                              selected: selected,
                              isSelectionEnabled: isSelectionMode,
                              onTap: () => viewModel.toggleSelection(t.id),
                              onLongPress: () => viewModel.startSelection(t.id),
                              onChanged: (done) => viewModel.setDone(t.id, done),
                              onEdit: () =>
                                  viewModel.updateTask(t.id, title: '${t.title} (editado)'),
                              onDelete: () => viewModel.deleteTask(t.id),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
