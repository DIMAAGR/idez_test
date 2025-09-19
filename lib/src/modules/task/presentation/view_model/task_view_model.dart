import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/state/view_model_state.dart';
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

      // Sanity checker: if selectedCategoryId is not in categories, reset it
      if (selectedCategoryId != null && !categories.any((c) => c.id == selectedCategoryId)) {
        selectedCategoryId = null;
      }
      return SuccessState(list);
    });
  }

  @action
  void setCategory(String? id) => selectedCategoryId = id;

  // ========================
  // Internal Helpers
  // ========================
  DateTime? _composeDueDateOrNull() {
    if (date.isEmpty) return null;
    final hhmm = time.isNotEmpty ? time : '23:59';
    try {
      return DateFormat('dd/MM/yyyy HH:mm').parse('$date $hhmm');
    } catch (_) {
      return null;
    }
  }

  TaskEntity _buildModelForCreate(String id) {
    return TaskEntity(
      id: id,
      title: title.trim(),
      done: false,
      createdAt: DateTime.now(),
      dueDate: _composeDueDateOrNull(),
      categoryId: selectedCategoryId,
    );
  }

  TaskEntity _buildModelForEdit({required String id, required DateTime originalCreatedAt}) {
    return TaskEntity(
      id: id,
      title: title.trim(),
      done: false,
      createdAt: originalCreatedAt,
      dueDate: _composeDueDateOrNull(),
      categoryId: selectedCategoryId,
    );
  }

  // ========================
  // Actions
  // ========================

  @action
  Future<void> createTask() async {
    state = LoadingState();

    final newId = Uuid().v4();

    final result = await _createTaskUseCase(_buildModelForCreate(newId));

    state = await result.fold((failure) async => ErrorState(failure), (_) => SuccessState(null));
  }

  @action
  Future<void> editTask({
    required String id,
    required DateTime originalCreatedAt,
    bool preserveDone = true,
    bool originalDoneValue = false,
  }) async {
    state = LoadingState();

    final model = _buildModelForEdit(id: id, originalCreatedAt: originalCreatedAt);

    final TaskEntity finalModel = preserveDone ? model.copyWith(done: originalDoneValue) : model;

    final result = await _editTaskUseCase(id, finalModel);

    state = await result.fold((failure) async => ErrorState(failure), (_) async {
      return SuccessState(null);
    });
  }
}
