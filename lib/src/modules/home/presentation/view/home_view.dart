import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'package:idez_test/src/core/router/app_routes.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';

import 'package:idez_test/src/modules/home/presentation/view/tabs/home_tab.dart';
import 'package:idez_test/src/modules/home/presentation/view/tabs/done_tab.dart';
import 'package:idez_test/src/modules/home/presentation/widgets/fab_menu.dart';
import 'package:idez_test/src/modules/home/presentation/widgets/bottom_pill_nav.dart';

import '../../../../core/mixin/pending_deletion_mixin.dart';
import '../../../../core/state/view_model_state.dart';
import '../models/pill_tab_enum.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with PendingDeletionMixin {
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    widget.viewModel.loadAllData();

    _disposers.addAll([
      reaction((_) => widget.viewModel.tasksState, (state) {
        if (state is ErrorState) _showError(state);
      }),
      reaction((_) => widget.viewModel.categoriesState, (state) {
        if (state is ErrorState) _showError(state);
      }),
      reaction((_) => widget.viewModel.doneTasksState, (state) {
        if (state is ErrorState) _showError(state);
      }),
      reaction((_) => widget.viewModel.updateTaskState, (state) {
        if (state is ErrorState) _showError(state);
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

  @override
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  Future<void> _beforeNavigate() async {
    await commitPendingIfAny(widget.viewModel.commitDeleteRange);
  }

  void _requestDelete({
    required List<String> ids,
    required String message,
    required VoidCallback restore,
  }) {
    showPendingDeletion(
      context: context,
      ids: ids,
      message: message,
      restore: restore,
      commit: widget.viewModel.commitDeleteRange,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Observer(
          builder: (_) {
            final selection = widget.viewModel.isSelectionMode;
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: selection
                  ? AppBar(
                      key: const ValueKey('selection-appbar'),
                      leading: IconButton(
                        icon: Icon(Icons.close, color: colors.black),
                        onPressed: widget.viewModel.clearSelection,
                        tooltip: 'Cancelar seleção',
                      ),
                      titleSpacing: 0,
                      title: Text(
                        '${widget.viewModel.selectedCount} selecionada(s)',
                        style: AppTheme.of(context).textStyles.body1Regular,
                      ),
                      actions: [
                        IconButton(
                          tooltip: 'Excluir selecionadas',
                          icon: Icon(Icons.delete, color: colors.red),
                          onPressed: widget.viewModel.selectedCount == 0
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
                        ),
                      ],
                    )
                  : SizedBox(height: 48),
            );
          },
        ),
      ),
      body: Observer(
        builder: (_) => widget.viewModel.currentTab == PillTab.home
            ? HomeTab(
                viewModel: widget.viewModel,
                onBeforeNavigate: _beforeNavigate,
                onDeleteRequest: _requestDelete,
              )
            : DoneTab(
                viewModel: widget.viewModel,
                onBeforeNavigate: _beforeNavigate,
                onDeleteRequest: _requestDelete,
              ),
      ),
      floatingActionButton: FabMenu(
        onNewTask: () => Navigator.pushNamed(context, AppRoutes.createTask).then((value) async {
          if (value == true) {
            widget.viewModel.loadAllData();
          }
        }),
        onNewCategory: () => Navigator.pushNamed(context, AppRoutes.createCategory).then((value) {
          if (value == true) {
            widget.viewModel.loadAllData();
          }
        }),
      ),
      bottomNavigationBar: Observer(
        builder: (_) => BottomPillNav(
          current: widget.viewModel.currentTab,
          onChanged: (tab) => widget.viewModel.currentTab = tab,
        ),
      ),
    );
  }
}
