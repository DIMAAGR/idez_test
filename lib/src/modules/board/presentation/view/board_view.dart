import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/core/mixin/pending_deletion_mixin.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';
import 'package:idez_test/src/modules/board/presentation/view_model/board_view_model.dart';
import 'package:idez_test/src/modules/board/presentation/widgets/actions_buttons.dart';
import 'package:idez_test/src/modules/board/presentation/widgets/board_filter.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/delete_button.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/fade_in.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/task_view_body.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/state/view_model_state.dart';
import '../../../shared/presentation/widgets/task_tile.dart';
import '../../domain/enums/board_type_enum.dart';

class BoardView extends StatefulWidget {
  final BoardViewModel viewModel;
  final String? boardType;
  const BoardView({super.key, required this.viewModel, this.boardType});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> with PendingDeletionMixin {
  final List<ReactionDisposer> _disposers = [];

  final _scrollCtrl = ScrollController();

  int _maxAnimatedIndex = -1;
  bool _allowStagger = true;

  Duration _staggerFor(int index) {
    const window = 12;
    if (!_allowStagger) return Duration.zero;
    if (index <= _maxAnimatedIndex) return Duration.zero;
    if (index > window) return Duration.zero;

    _maxAnimatedIndex = index;

    return Duration(milliseconds: 80 + index * 40);
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadBoard(widget.boardType);
    widget.viewModel.loadAllData();

    _disposers.addAll([
      reaction((_) => widget.viewModel.tasksState, (state) {
        if (state is ErrorState) _showError(state);
      }),
      reaction((_) => widget.viewModel.updateTaskState, (state) {
        if (state is ErrorState) _showError(state);
      }),

      reaction((_) => widget.viewModel.deleteRangeState, (state) {
        if (state is ErrorState) {
          _showError(state);
        } else if (state is SuccessState) {
          _showInfo('Exclusão concluída');
        }
      }),
    ]);
  }

  void _showError(Object error) {
    final colors = AppTheme.of(context).colors;
    final msg = error.toString();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: colors.red));
  }

  void _showInfo(String msg) {
    final colors = AppTheme.of(context).colors;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: colors.darkGrey));
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  void _openFiltersSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Observer(
        builder: (context) {
          return BoardFilter(
            categories:
                widget.viewModel.tasks
                    .map((t) => t.categoryId)
                    .whereType<String>()
                    .where((id) => id.isNotEmpty)
                    .toSet()
                    .toList()
                  ..sort(),
            getCategoryNameById: widget.viewModel.getCategoryNameById,
            hidePending:
                widget.viewModel.boardType == BoardType.pending ||
                widget.viewModel.boardType == BoardType.overdue,
            selectedFilter: widget.viewModel.filter,
            onFilterSelected: (f) => widget.viewModel.setFilter(f),
            selectedCategoryId: widget.viewModel.selectedCategoryId,
            onCategorySelected: (id) => widget.viewModel.setCategory(id),
            onClearFilters: () => widget.viewModel.clearFilters(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;

    return PopScope(
      onPopInvokedWithResult: (result, _) async {
        await commitPendingIfAny(widget.viewModel.commitDeleteRange);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Observer(
            builder: (_) {
              final sel = widget.viewModel.isSelectionMode;
              return AppBar(
                elevation: 0,
                leading: SizedBox(
                  width: kToolbarHeight,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      IgnorePointer(
                        ignoring: sel,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 180),
                          opacity: sel ? 0 : 1,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: colors.black),
                            onPressed: () async {
                              await commitPendingIfAny(widget.viewModel.commitDeleteRange);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: !sel,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 180),
                          opacity: sel ? 1 : 0,
                          child: IconButton(
                            icon: Icon(Icons.close, color: colors.black),
                            onPressed: widget.viewModel.clearSelection,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  SizedBox(
                    width: 112,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        ActionsButtons(
                          hasActiveFilters: widget.viewModel.hasActiveFilters,
                          isActivated: sel,
                          onActiveFiltersPressed: () => _openFiltersSheet(context),
                          onAddTaskPressed: () async {
                            final ok = await Navigator.pushNamed(context, AppRoutes.createTask);
                            if (ok == true) widget.viewModel.loadAllData();
                          },
                        ),
                        Observer(
                          builder: (_) {
                            final hasSel = widget.viewModel.selectedCount > 0;
                            return DeleteButton(
                              isActivated: sel,
                              onDelete: !hasSel
                                  ? null
                                  : () {
                                      final ids = widget.viewModel.selectedTasksIDs.toList();
                                      final removed = widget.viewModel.removeByIdsOptimistic(ids);

                                      showPendingDeletion(
                                        context: context,
                                        ids: ids,
                                        message: '${removed.length} tarefa(s) excluída(s)',
                                        restore: () => widget.viewModel.restoreTasks(removed),
                                        commit: widget.viewModel.commitDeleteRange,
                                      );
                                    },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              );
            },
          ),
        ),
        body: TaskViewBody(
          padding: const EdgeInsets.all(16),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          hasScrollableChild: true,
          children: [
            const SizedBox(height: 24),
            FadeIn(
              delay: const Duration(milliseconds: 300),
              child: Observer(
                builder: (_) => Text(
                  widget.viewModel.hasActiveFilters
                      ? 'Tarefas Filtradas'
                      : _titleForBoard(widget.viewModel.boardType),
                  style: AppTheme.of(context).textStyles.h5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Observer(
                builder: (context) {
                  final items = widget.viewModel.visibleTasks;
                  if (items.isEmpty) {
                    return FadeIn(
                      delay: const Duration(milliseconds: 500),
                      child: Center(
                        child: Text(
                          'Nenhuma tarefa encontrada.\nClique no botão + para adicionar uma nova tarefa.',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context).textStyles.body1Regular.copyWith(
                            color: AppTheme.of(context).colors.grey,
                          ),
                        ),
                      ),
                    );
                  }

                  return NotificationListener<UserScrollNotification>(
                    onNotification: (n) {
                      if (n.direction != ScrollDirection.idle) {
                        _allowStagger = false;
                      }
                      return false;
                    },
                    child: ListView.separated(
                      controller: _scrollCtrl,
                      itemCount: widget.viewModel.visibleTasks.length,
                      separatorBuilder: (_, i) => FadeIn(
                        delay: _staggerFor(i) ~/ 2,
                        duration: const Duration(milliseconds: 180),
                        child: Divider(color: AppTheme.of(context).colors.grey.withAlpha(70)),
                      ),
                      itemBuilder: (_, i) {
                        final t = widget.viewModel.visibleTasks[i];
                        return FadeIn(
                          delay: _staggerFor(i),
                          duration: const Duration(milliseconds: 220),
                          child: Observer(
                            builder: (_) {
                              final selected = widget.viewModel.selectedTasksIDs.contains(t.id);
                              final isSelectionMode = widget.viewModel.isSelectionMode;

                              return TaskTile(
                                id: t.id,
                                title: t.title,
                                date: t.dueDate,
                                isCompleted: t.done,
                                category:
                                    widget.viewModel.getCategoryNameById(t.categoryId) ?? 'nenhuma',
                                selected: selected,
                                isSelectionEnabled: isSelectionMode,
                                onTap: () => widget.viewModel.toggleSelection(t.id),
                                onLongPress: () => widget.viewModel.startSelection(t.id),
                                onChanged: (done) => widget.viewModel.setDone(t.id, done),
                                onEdit: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(AppRoutes.editTask, arguments: t).then((ok) {
                                    if (ok == true) widget.viewModel.loadAllData();
                                  });
                                },
                                onDelete: () {
                                  final removed = widget.viewModel.removeByIdOptimistic(t.id);
                                  if (removed == null) return;

                                  showPendingDeletion(
                                    context: context,
                                    ids: [t.id],
                                    message: 'Tarefa excluída',
                                    restore: () => widget.viewModel.restoreTasks([removed]),
                                    commit: (ids) => widget.viewModel.commitDeleteRange(ids),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _titleForBoard(BoardType type) {
    switch (type) {
      case BoardType.all:
        return 'Todas as Tarefas';
      case BoardType.pending:
        return 'Tarefas Pendentes';
      case BoardType.overdue:
        return 'Tarefas Atrasadas';
    }
  }
}
