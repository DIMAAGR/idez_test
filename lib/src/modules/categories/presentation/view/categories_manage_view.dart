import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/state/view_model_state.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../shared/domain/entities/category_entity.dart';
import '../../../shared/presentation/widgets/task_text_form_field.dart';
import '../../../shared/presentation/widgets/task_view_body.dart';
import '../view_model/categories_view_model.dart';

class CategoriesManageView extends StatefulWidget {
  final CategoriesViewModel viewModel;
  final bool isCreate;
  final CategoryEntity? category;
  const CategoriesManageView({
    super.key,
    required this.viewModel,
    this.isCreate = false,
    this.category,
  });

  @override
  State<CategoriesManageView> createState() => _CategoriesManageViewState();
}

class _CategoriesManageViewState extends State<CategoriesManageView> {
  final TextEditingController _nameController = TextEditingController();

  late final ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    if (!widget.isCreate && widget.category != null) {
      _nameController.text = widget.category!.name;
      widget.viewModel.name = widget.category!.name;
    }

    _nameController.addListener(() {
      widget.viewModel.name = _nameController.text;
    });

    _disposer = reaction<ViewModelState>((_) => widget.viewModel.manageState, (state) {
      if (state is ErrorState) {
        final failure = (state).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              failure.message ?? 'Erro inesperado',
              style: AppTheme.textStyles.body2Regular.copyWith(color: Colors.white),
            ),
            backgroundColor: AppTheme.colors.red,
          ),
        );
      } else if (state is SuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Categoria salva com sucesso!',
              style: AppTheme.textStyles.body2Regular.copyWith(color: Colors.white),
            ),
            backgroundColor: AppTheme.colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    });
  }

  @override
  void dispose() {
    _disposer();
    _nameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isCreate ? 'Nova Categoria' : 'Editar Categoria',
          style: AppTheme.textStyles.body1Regular,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  if (widget.isCreate) {
                    widget.viewModel.createCategory();
                  } else {
                    widget.viewModel.editCategory(widget.category!.id);
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
            style: AppTheme.textStyles.h5,
          ),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TaskTextFormField(
                  controller: _nameController,
                  titleText: 'Nome da categoria*',
                  hintText: 'Ex: Trabalho',
                  validator: validateTitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
