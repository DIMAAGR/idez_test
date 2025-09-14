import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/fade_in.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/task_tile.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../view_model/home_view_model.dart';

class DoneTab extends StatelessWidget {
  final HomeViewModel viewModel;
  const DoneTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              FadeIn(
                delay: const Duration(milliseconds: 200),
                child: Text('Tarefas Concluídas', style: AppTheme.textStyles.h5),
              ),
              SizedBox(height: 24),
              Observer(
                builder: (context) {
                  final done = viewModel.doneTasks;

                  if (done.isEmpty) {
                    return FadeIn(
                      delay: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 48.0),
                        child: Center(
                          child: Text(
                            'Nenhuma tarefa concluída ainda.',
                            style: AppTheme.textStyles.body1Regular.copyWith(
                              color: AppTheme.colors.darkGrey,
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
                    itemCount: done.length,
                    separatorBuilder: (context, index) => FadeIn(
                      delay: Duration(milliseconds: 300 + index * 100),
                      child: Divider(color: AppTheme.colors.grey.withAlpha(70)),
                    ),
                    itemBuilder: (context, index) {
                      return FadeIn(
                        delay: Duration(milliseconds: 300 + index * 100),
                        child: Observer(
                          builder: (context) {
                            final t = done[index];

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
                              onDelete: () {
                                () {
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
                                };
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
