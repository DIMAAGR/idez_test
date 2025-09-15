import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/mixin/pending_deletion_mixin.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/state/view_model_state.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/presentation/widgets/delete_button.dart';
import '../../../shared/presentation/widgets/fade_in.dart';
import '../../../shared/presentation/widgets/task_view_body.dart';
import '../view_model/categories_view_model.dart';
import '../widgets/category_tile.dart';

class CategoriesBoardView extends StatefulWidget {
  final CategoriesViewModel viewModel;
  const CategoriesBoardView({super.key, required this.viewModel});

  @override
  State<CategoriesBoardView> createState() => _CategoriesBoardViewState();
}

class _CategoriesBoardViewState extends State<CategoriesBoardView> with PendingDeletionMixin {
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadCategories();
    _disposers.addAll([
      reaction((_) => widget.viewModel.categoriesState, (state) {
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
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colors;

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
                backgroundColor: Colors.white,
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
                    width: 40,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        IgnorePointer(
                          ignoring: sel,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 180),
                            opacity: !sel ? 1 : 0,
                            child: IconButton(
                              tooltip: 'Adicionar tarefa',
                              icon: Icon(Icons.add_rounded, color: AppTheme.colors.darkGrey),
                              onPressed: () async {
                                final ok = await Navigator.pushNamed(
                                  context,
                                  AppRoutes.createCategory,
                                );
                                if (ok == true) widget.viewModel.loadCategories();
                              },
                            ),
                          ),
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
                                        message: '${removed.length} categoria(s) excluída(s)',
                                        restore: () => widget.viewModel.restoreCategories(removed),
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
          children: [
            const SizedBox(height: 24),
            FadeIn(
              delay: Duration(milliseconds: 300),
              child: Observer(
                builder: (context) {
                  return Text('Minhas Categorias', style: AppTheme.textStyles.h5);
                },
              ),
            ),
            const SizedBox(height: 24),
            Observer(
              builder: (context) {
                if (widget.viewModel.categories.isEmpty) {
                  return FadeIn(
                    delay: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Center(
                        child: Text(
                          'Nenhuma categoria encontrada.\nClique no botão + para adicionar uma nova categoria.',
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
                  itemCount: widget.viewModel.categories.length,
                  separatorBuilder: (context, index) => FadeIn(
                    delay: Duration(milliseconds: 500 + index * 100),
                    child: Divider(color: AppTheme.colors.grey.withAlpha(70)),
                  ),
                  itemBuilder: (context, index) {
                    return FadeIn(
                      delay: Duration(milliseconds: 500 + index * 100),
                      child: Observer(
                        builder: (context) {
                          final t = widget.viewModel.categories[index];

                          final selected = widget.viewModel.selectedTasksIDs.contains(t.id);
                          final isSelectionMode = widget.viewModel.isSelectionMode;

                          return CategoryTile(
                            id: t.id,
                            title: t.name,

                            selected: selected,
                            isSelectionEnabled: isSelectionMode,
                            onTap: () => widget.viewModel.toggleSelection(t.id),
                            onLongPress: () => widget.viewModel.startSelection(t.id),
                            onEdit: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.editCategory, arguments: t).then((value) {
                                if (value == true) {
                                  widget.viewModel.loadCategories();
                                }
                              });
                            },

                            onDelete: () {
                              final removed = widget.viewModel.removeByIdOptimistic(t.id);
                              if (removed == null) return;

                              showPendingDeletion(
                                context: context,
                                ids: [t.id],
                                message: 'Categoria excluída',
                                restore: () => widget.viewModel.restoreCategories([removed]),
                                commit: (ids) => widget.viewModel.commitDeleteRange(ids),
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
          ],
        ),
      ),
    );
  }
}
