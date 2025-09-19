import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/core/router/app_routes.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/fade_in.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/task_tile.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../view_model/home_view_model.dart';

class DoneTab extends StatefulWidget {
  final HomeViewModel viewModel;
  final Future<void> Function() onBeforeNavigate;
  final void Function({
    required List<String> ids,
    required String message,
    required VoidCallback restore,
  })
  onDeleteRequest;
  const DoneTab({
    super.key,
    required this.viewModel,
    required this.onBeforeNavigate,
    required this.onDeleteRequest,
  });

  @override
  State<DoneTab> createState() => _DoneTabState();
}

class _DoneTabState extends State<DoneTab> {
  HomeViewModel get vm => widget.viewModel;

  Future<void> _goToEditTask(dynamic t) async {
    await widget.onBeforeNavigate();
    final ok = await Navigator.of(context).pushNamed(AppRoutes.editTask, arguments: t);
    if (ok == true && mounted) vm.loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            FadeIn(
              delay: const Duration(milliseconds: 200),
              child: Text('Tarefas Concluídas', style: AppTheme.of(context).textStyles.h5),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Observer(
                builder: (_) {
                  final done = vm.doneTasks;

                  if (done.isEmpty) {
                    return FadeIn(
                      delay: const Duration(milliseconds: 300),
                      child: Center(
                        child: Text(
                          'Nenhuma tarefa concluída ainda.',
                          style: AppTheme.of(context).textStyles.body1Regular.copyWith(
                            color: AppTheme.of(context).colors.darkGrey,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    addAutomaticKeepAlives: false,
                    itemCount: done.length,
                    separatorBuilder: (context, index) => FadeIn(
                      delay: Duration(milliseconds: 220 + index * 60),
                      duration: const Duration(milliseconds: 240),
                      child: Divider(color: AppTheme.of(context).colors.grey.withAlpha(70)),
                    ),
                    itemBuilder: (context, index) {
                      final t = done[index];

                      return FadeIn(
                        delay: Duration(milliseconds: 180 + index * 60),
                        duration: const Duration(milliseconds: 260),
                        child: Observer(
                          builder: (_) {
                            final selected = vm.selectedTasksIDs.contains(t.id);
                            final isSelectionMode = vm.isSelectionMode;

                            return TaskTile(
                              id: t.id,
                              title: t.title,
                              date: t.dueDate,
                              isCompleted: t.done,
                              category: vm.getCategoryNameById(t.categoryId) ?? 'nenhuma',
                              selected: selected,
                              isSelectionEnabled: isSelectionMode,
                              onTap: () => vm.toggleSelection(t.id),
                              onLongPress: () => vm.startSelection(t.id),
                              onChanged: (done) => vm.setDone(t.id, done),

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
            ),
          ],
        ),
      ),
    );
  }
}
