import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'package:idez_test/src/core/router/app_routes.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';

import 'package:idez_test/src/modules/home/presentation/view/tabs/home_tab.dart';
import 'package:idez_test/src/modules/home/presentation/view/tabs/done_tab.dart';
import 'package:idez_test/src/modules/home/presentation/widgets/fab_menu.dart';
import 'package:idez_test/src/modules/home/presentation/widgets/bottom_pill_nav.dart';

import '../../../../core/state/view_model_state.dart';
import '../models/pill_tab_enum.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    final colors = AppTheme.colors;
    final msg = error.toString();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: colors.red));
  }

  void _showInfo(String msg) {
    final colors = AppTheme.colors;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: colors.darkGrey));
  }

  @override
  void dispose() {
    for (final d in _disposers) d();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colors;

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
                        style: AppTheme.textStyles.body1Regular,
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

                                  bool undone = false;
                                  final bar = ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${removed.length} tarefa(s) excluída(s)'),
                                      action: SnackBarAction(
                                        label: 'Desfazer',
                                        onPressed: () {
                                          undone = true;
                                          widget.viewModel.restoreTasks(removed);
                                        },
                                      ),
                                      duration: const Duration(seconds: 4),
                                    ),
                                  );

                                  bar.closed.then((_) {
                                    if (!undone) {
                                      widget.viewModel.commitDeleteRange(ids);
                                    }
                                  });
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
            ? HomeTab(viewModel: widget.viewModel)
            : DoneTab(viewModel: widget.viewModel),
      ),
      floatingActionButton: FabMenu(
        onNewTask: () => Navigator.pushNamed(context, AppRoutes.createTask).then((value) {
          if (value == true) {
            widget.viewModel.loadAllData();
          }
        }),
        onNewCategory: () {
          // Navigator.pushNamed(context, AppRoutes.createCategory);
        },
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
