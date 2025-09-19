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

class HomeTab extends StatefulWidget {
  final HomeViewModel viewModel;
  final Future<void> Function() onBeforeNavigate;
  final void Function({
    required List<String> ids,
    required String message,
    required VoidCallback restore,
  })
  onDeleteRequest;
  const HomeTab({
    super.key,
    required this.viewModel,
    required this.onBeforeNavigate,
    required this.onDeleteRequest,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeViewModel get viewModel => widget.viewModel;

  Future<void> _goToBoard(String arg) async {
    await widget.onBeforeNavigate();
    await Navigator.of(context).pushNamed(AppRoutes.board, arguments: arg);
    if (mounted) viewModel.loadAllData();
  }

  Future<void> _goToCategories() async {
    await widget.onBeforeNavigate();
    await Navigator.of(context).pushNamed(AppRoutes.categories);
    if (mounted) viewModel.loadAllData();
  }

  Future<void> _goToEditTask(dynamic t) async {
    await widget.onBeforeNavigate();
    final ok = await Navigator.of(context).pushNamed(AppRoutes.editTask, arguments: t);
    if (ok == true) viewModel.loadAllData();
  }

  Future<void> _goToSettings() async {
    await widget.onBeforeNavigate();
    final ok = await Navigator.of(context).pushNamed(AppRoutes.settings);
    if (ok == true) viewModel.loadAllData();
  }

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
                child: HomeTitle(
                  onSettingsPressed: () async {
                    await _goToSettings();
                  },
                ),
              ),
              const SizedBox(height: 24),
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
                      onTasksPressed: () => _goToBoard('ALL'),
                      onCategoriesPressed: () => _goToCategories(),
                      onOverdueTasksPressed: () => _goToBoard('OVERDUE'),
                      onPendingTasksPressed: () => _goToBoard('PENDING'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              FadeIn(
                delay: const Duration(milliseconds: 400),
                child: Text('Recentes', style: AppTheme.of(context).textStyles.body1Bold),
              ),
              const SizedBox(height: 16),

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
                            style: AppTheme.of(context).textStyles.body1Regular.copyWith(
                              color: AppTheme.of(context).colors.grey,
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.lastTasks.length,
                    separatorBuilder: (context, index) => FadeIn(
                      delay: Duration(milliseconds: 500 + index * 100),
                      child: Divider(color: AppTheme.of(context).colors.grey.withAlpha(70)),
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

                              onEdit: () => _goToEditTask(t),

                              onDelete: () {
                                final removed = widget.viewModel.removeByIdOptimistic(t.id);
                                if (removed == null) return;

                                widget.onDeleteRequest(
                                  ids: [t.id],
                                  message: 'Tarefa excluída',
                                  restore: () => widget.viewModel.restoreTasks([removed]),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
