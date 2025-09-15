import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/core/router/app_routes.dart';
import 'package:idez_test/src/modules/home/presentation/view_model/home_view_model.dart';
import 'package:idez_test/src/modules/home/presentation/widgets/home_title.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/fade_in.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/task_tile.dart';

import '../../../../../core/state/view_model_state.dart';
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
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 24.0),
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
                      isCategoryLoading: viewModel.categoriesState is LoadingState,
                      isTaskLoading: viewModel.tasksState is LoadingState,
                      tasksCount: viewModel.tasks.length,
                      categoriesCount: viewModel.categoriesCount,
                      overdueTasksCount: viewModel.overdueTasksCount,
                      pendingTasksCount: viewModel.pendingTasksCount,
                      onTasksPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.board, arguments: 'ALL')
                          .then((_) => viewModel.loadAllData()),
                      onCategoriesPressed: () => Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.categories).then((_) => viewModel.loadAllData()),
                      onOverdueTasksPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.board, arguments: 'OVERDUE')
                          .then((_) => viewModel.loadAllData()),
                      onPendingTasksPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.board, arguments: 'PENDING')
                          .then((_) => viewModel.loadAllData()),
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
                  if (viewModel.tasks.isEmpty) {
                    return FadeIn(
                      delay: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 48.0),
                        child: Center(
                          child: Text(
                            'Nenhuma tarefa encontrada.\nClique no botão + para adicionar uma nova tarefa.',
                            textAlign: TextAlign.center,
                            style: AppTheme.textStyles.body1Regular.copyWith(
                              color: AppTheme.colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    cacheExtent: 0,
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: viewModel.lastTasks.length,
                    separatorBuilder: (context, index) => FadeIn(
                      delay: Duration(milliseconds: 500 + index * 100),
                      child: Divider(color: AppTheme.colors.grey.withAlpha(70)),
                    ),
                    itemBuilder: (context, index) {
                      return FadeIn(
                        delay: Duration(milliseconds: 500 + index * 100),
                        child: Observer(
                          builder: (context) {
                            final t = viewModel.lastTasks[index];

                            final selected = viewModel.selectedTasksIDs.contains(t.id);
                            final isSelectionMode = viewModel.isSelectionMode;

                            return TaskTile(
                              id: t.id,
                              title: t.title,
                              date: t.dueDate,
                              isCompleted: t.done,
                              category: viewModel.getCategoryNameById(t.categoryId) ?? 'nenhuma',
                              selected: selected,
                              isSelectionEnabled: isSelectionMode,
                              onTap: () => viewModel.toggleSelection(t.id),
                              onLongPress: () => viewModel.startSelection(t.id),
                              onChanged: (done) => viewModel.setDone(t.id, done),
                              onEdit: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.editTask, arguments: t).then((value) {
                                  if (value == true) {
                                    viewModel.loadAllData();
                                  }
                                });
                              },

                              onDelete: () {
                                final removed = viewModel.removeByIdOptimistic(t.id);

                                bool undone = false;
                                final bar = ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('tarefa excluída'),
                                    action: SnackBarAction(
                                      label: 'Desfazer',
                                      onPressed: () {
                                        undone = true;
                                        viewModel.restoreTasks([removed!]);
                                      },
                                    ),
                                    duration: const Duration(seconds: 4),
                                  ),
                                );

                                bar.closed.then((_) {
                                  if (!undone) {
                                    viewModel.commitDeleteOne(t.id);
                                  }
                                });
                              },
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
