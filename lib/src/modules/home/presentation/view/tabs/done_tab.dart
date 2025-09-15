import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/core/mixin/pending_deletion_mixin.dart';
import 'package:idez_test/src/core/router/app_routes.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/fade_in.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/task_tile.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../view_model/home_view_model.dart';

class DoneTab extends StatefulWidget {
  final HomeViewModel viewModel;
  const DoneTab({super.key, required this.viewModel});

  @override
  State<DoneTab> createState() => _DoneTabState();
}

class _DoneTabState extends State<DoneTab> with PendingDeletionMixin {
  HomeViewModel get vm => widget.viewModel;

  Future<void> _goToEditTask(dynamic t) async {
    await commitPendingIfAny(vm.commitDeleteRange);
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
              child: Text('Tarefas Concluídas', style: AppTheme.textStyles.h5),
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
                          style: AppTheme.textStyles.body1Regular.copyWith(
                            color: AppTheme.colors.darkGrey,
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
                      child: Divider(color: AppTheme.colors.grey.withAlpha(70)),
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
                                // Remoção otimista + snackbar com desfazer
                                final removed = vm.removeByIdOptimistic(t.id);
                                if (removed == null) return;

                                showPendingDeletion(
                                  context: context,
                                  ids: [t.id],
                                  message: 'Tarefa excluída',
                                  restore: () => vm.restoreTasks([removed]),
                                  commit: (ids) => vm.commitDeleteRange(ids),
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
