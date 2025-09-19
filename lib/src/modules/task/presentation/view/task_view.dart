import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/core/extensions/date_time_extension.dart';
import 'package:idez_test/src/core/masks/text_input_date_formatter.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';
import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/task_text_form_field.dart';
import 'package:idez_test/src/modules/shared/presentation/widgets/task_view_body.dart';
import 'package:idez_test/src/core/validators/validators.dart';
import 'package:idez_test/src/modules/task/presentation/view_model/task_view_model.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/state/view_model_state.dart';

class TaskView extends StatefulWidget {
  final TaskViewModel viewModel;
  final bool isCreate;
  final TaskEntity? task;
  const TaskView({super.key, required this.viewModel, this.isCreate = false, this.task});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late final ReactionDisposer _taskDisposer;

  @override
  void initState() {
    super.initState();

    if (!widget.isCreate && widget.task != null) {
      _titleController.text = widget.task!.title;
      _dateController.text = widget.task!.dueDate?.toDDMMYYYY() ?? '';
      _timeController.text = widget.task!.dueDate?.toHHMM() ?? '';
      widget.viewModel.title = widget.task!.title;
      widget.viewModel.date = _dateController.text;
      widget.viewModel.time = _timeController.text;
      widget.viewModel.selectedCategoryId = widget.task!.categoryId;
    }

    _titleController.addListener(() {
      widget.viewModel.title = _titleController.text;
    });
    _dateController.addListener(() {
      widget.viewModel.date = _dateController.text;
    });
    _timeController.addListener(() {
      widget.viewModel.time = _timeController.text;
    });

    widget.viewModel.loadCategories();

    _taskDisposer = reaction<ViewModelState>((_) => widget.viewModel.state, (state) {
      if (state is ErrorState) {
        final failure = (state).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              failure.message ?? 'Erro inesperado',
              style: AppTheme.of(context).textStyles.body2Regular.copyWith(color: Colors.white),
            ),
            backgroundColor: AppTheme.of(context).colors.red,
          ),
        );
      } else if (state is SuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Tarefa salva com sucesso!',
              style: AppTheme.of(context).textStyles.body2Regular.copyWith(color: Colors.white),
            ),
            backgroundColor: AppTheme.of(context).colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    });
  }

  @override
  void dispose() {
    _taskDisposer();
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isCreate ? 'Nova Tarefa' : 'Editar Tarefa',
          style: AppTheme.of(context).textStyles.body1Regular,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.of(context).colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),

              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  if (widget.isCreate) {
                    widget.viewModel.createTask();
                  } else {
                    widget.viewModel.editTask(
                      id: widget.task!.id,
                      originalCreatedAt: widget.task!.createdAt,
                      preserveDone: true,
                      originalDoneValue: widget.task!.done,
                    );
                  }
                }
              },
              child: Text('Salvar'),
            ),
          ),
        ],
      ),
      body: TaskViewBody(
        padding: EdgeInsets.all(16),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isCreate ? 'Criar uma nova tarefa' : 'Editar tarefa',
            style: AppTheme.of(context).textStyles.h5,
          ),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TaskTextFormField(
                  controller: _titleController,
                  titleText: 'Título da tarefa*',
                  hintText: 'Fazer 30 minutos de meditação',
                  validator: validateTitle,
                ),
                SizedBox(height: 24),
                TaskTextFormField(
                  controller: _dateController,
                  titleText: 'Data (Opcional)',
                  hintText: 'DD/MM/AAAA',
                  inputMask: TextInputDateFormatter.dateMask,
                  validator: validateDate,
                ),
                SizedBox(height: 24),
                TaskTextFormField(
                  controller: _timeController,
                  titleText: 'Hora (Opcional)',
                  hintText: 'HH:MM',
                  inputMask: TextInputDateFormatter.timeMask,
                  validator: (s) => validateTime(s, dateStr: _dateController.text),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Categoria (Opcional)', style: AppTheme.of(context).textStyles.button),
          ),
          const SizedBox(height: 4),
          Observer(
            builder: (_) {
              final catState = widget.viewModel.categoriesState;

              if (catState is LoadingState) {
                return const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }

              if (catState is ErrorState) {
                return Row(
                  children: [
                    Text(
                      'Falha ao carregar categorias',
                      style: AppTheme.of(
                        context,
                      ).textStyles.caption.copyWith(color: AppTheme.of(context).colors.red),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: widget.viewModel.loadCategories,
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                );
              }

              final items = widget.viewModel.categories;

              final loading = catState is LoadingState;
              return AbsorbPointer(
                absorbing: loading,
                child: Opacity(
                  opacity: loading ? 0.6 : 1,
                  child: DropdownButtonFormField<String?>(
                    isExpanded: true,
                    value: widget.viewModel.selectedCategoryId,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppTheme.of(context).colors.grey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppTheme.of(context).colors.blue, width: 2),
                      ),
                    ),
                    hint: const Text('Selecionar categoria'),
                    items: [
                      const DropdownMenuItem<String?>(value: null, child: Text('Sem categoria')),
                      ...items.map(
                        (c) => DropdownMenuItem<String?>(
                          value: c.id,
                          child: Text(c.name.isNotEmpty ? c.name : c.id),
                        ),
                      ),
                    ],
                    onChanged: (val) => widget.viewModel.setCategory(val),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
