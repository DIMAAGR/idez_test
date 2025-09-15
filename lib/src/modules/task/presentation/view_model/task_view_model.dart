// task_view_model.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/state/view_model_state.dart';
import '../../../shared/data/models/task_model.dart';
import '../../../shared/domain/entities/category_entity.dart';
import '../../../shared/domain/usecases/get_all_categories_use_case.dart';
import '../../../shared/domain/usecases/update_task_from_id_use_case.dart';
import '../../domain/usecases/create_task_use_case.dart';

part 'task_view_model.g.dart';

class TaskViewModel = _TaskViewModelBase with _$TaskViewModel;

abstract class _TaskViewModelBase with Store {
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskFromIdUseCase _editTaskUseCase;
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  _TaskViewModelBase(this._createTaskUseCase, this._editTaskUseCase, this._getAllCategoriesUseCase);

  String title = '';
  String date = '';
  String time = '';

  @observable
  String? selectedCategoryId;

  @observable
  ObservableList<CategoryEntity> categories = ObservableList.of([]);

  @observable
  ViewModelState<Failure, void> state = InitialState();

  @observable
  ViewModelState<Failure, List<CategoryEntity>> categoriesState = InitialState();

  @action
  Future<void> loadCategories() async {
    categoriesState = LoadingState();
    final res = await _getAllCategoriesUseCase();
    categoriesState = res.fold((f) => ErrorState(f), (list) {
      categories = ObservableList.of(list);
      return SuccessState(list);
    });
  }

  @action
  void setCategory(String? id) => selectedCategoryId = id;

  @action
  Future<void> createTask() async {
    state = LoadingState();

    final result = await _createTaskUseCase(
      TaskModel(
        id: UniqueKey().toString(),
        title: title,
        done: false,
        createdAt: DateTime.now().toIso8601String(),
        dueDate: date.isNotEmpty
            ? DateFormat(
                'dd/MM/yyyy HH:mm',
              ).parse('$date ${time.isNotEmpty ? time : '23:59'}').toIso8601String()
            : null,
        categoryId: selectedCategoryId, // NEW
      ),
    );

    state = result.fold((failure) => ErrorState(failure), (_) => SuccessState(null));
  }

  @action
  Future<void> editTask(String id) async {
    state = LoadingState();

    final result = await _editTaskUseCase(
      id,
      TaskModel(
        id: id,
        title: title,
        done: false,
        createdAt: DateTime.now().toIso8601String(),
        dueDate: date.isNotEmpty
            ? DateFormat(
                'dd/MM/yyyy HH:mm',
              ).parse('$date ${time.isNotEmpty ? time : '23:59'}').toIso8601String()
            : null,
        categoryId: selectedCategoryId, // NEW
      ),
    );

    state = result.fold((failure) => ErrorState(failure), (_) => SuccessState(null));
  }
}
