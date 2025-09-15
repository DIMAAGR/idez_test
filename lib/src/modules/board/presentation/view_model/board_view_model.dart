import 'package:dartz/dartz.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_all_categories_use_case.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/state/view_model_state.dart';
import '../../../shared/data/models/task_model.dart';
import '../../../shared/domain/entities/category_entity.dart';
import '../../../shared/domain/entities/task_entity.dart';
import '../../../shared/domain/usecases/delete_from_id_range_use_case.dart';
import '../../../shared/domain/usecases/delete_from_id_use_case.dart';
import '../../../shared/domain/usecases/get_all_tasks_use_case.dart';
import '../../../shared/domain/usecases/update_task_from_id_use_case.dart';
import '../../domain/enums/board_type_enum.dart';
import '../../domain/enums/task_filter_enum.dart';

part 'board_view_model.g.dart';

class BoardViewModel = _BoardViewModel with _$BoardViewModel;

abstract class _BoardViewModel with Store {
  final GetAllTasksUseCase _allTasksUseCase;
  final UpdateTaskFromIdUseCase _updateTaskFromIdUseCase;
  final DeleteFromIdUseCase _deleteFromIdUseCase;
  final DeleteFromIdRangeUseCase _deleteFromIdRangeUseCase;
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  _BoardViewModel(
    this._allTasksUseCase,
    this._updateTaskFromIdUseCase,
    this._deleteFromIdUseCase,
    this._deleteFromIdRangeUseCase,
    this._getAllCategoriesUseCase,
  );

  @observable
  BoardType boardType = BoardType.all;

  @action
  void loadBoard(String? type) {
    boardType = BoardType.fromString(type ?? 'ALL');
  }

  // ----------------------------
  // States and results
  // ----------------------------

  @observable
  ViewModelState<Failure, List<TaskEntity>> tasksState = InitialState();

  @observable
  ViewModelState<Failure, List<CategoryEntity>> categoriesState = InitialState();

  @observable
  ViewModelState<Failure, void> deleteRangeState = InitialState();

  @observable
  ViewModelState<Failure, void> deleteOneState = InitialState();
  @observable
  ViewModelState<Failure, void> updateTaskState = InitialState();

  @observable
  ObservableList<TaskEntity> tasks = ObservableList.of([]);

  // ----------------------------
  // Filter
  // ----------------------------
  @observable
  TaskFilter filter = TaskFilter.all;

  @observable
  String? selectedCategoryId;

  @action
  void setFilter(TaskFilter f) => filter = f;

  @action
  void setCategory(String? id) => selectedCategoryId = id;

  @action
  void clearFilters() {
    filter = TaskFilter.all;
    selectedCategoryId = null;
  }

  @computed
  bool get hasActiveFilters =>
      filter != TaskFilter.all || (selectedCategoryId != null && selectedCategoryId!.isNotEmpty);

  // ----------------------------
  // Collections
  // ----------------------------

  @computed
  List<TaskEntity> get visibleTasks {
    Iterable<TaskEntity> list = tasks;

    final now = DateTime.now();
    switch (boardType) {
      case BoardType.all:
        break;
      case BoardType.pending:
        list = list.where((t) => !t.done && (t.dueDate == null || t.dueDate!.isAfter(now)));
        break;
      case BoardType.overdue:
        list = list.where((t) => !t.done && t.dueDate != null && t.dueDate!.isBefore(now));
        break;
    }

    DateTime startOfWeek(DateTime d) => d.subtract(Duration(days: d.weekday - 1));
    DateTime endOfWeek(DateTime d) => startOfWeek(d).add(const Duration(days: 7));

    switch (filter) {
      case TaskFilter.all:
        break;
      case TaskFilter.pending:
        list = list.where((t) => !t.done);
        break;
      case TaskFilter.done:
        list = list.where((t) => t.done);
        break;
      case TaskFilter.today:
        list = list.where(
          (t) =>
              t.dueDate != null &&
              t.dueDate!.year == now.year &&
              t.dueDate!.month == now.month &&
              t.dueDate!.day == now.day,
        );
        break;
      case TaskFilter.thisWeek:
        final start = startOfWeek(now);
        final end = endOfWeek(now);
        list = list.where(
          (t) => t.dueDate != null && t.dueDate!.isAfter(start) && t.dueDate!.isBefore(end),
        );
        break;
    }

    if (selectedCategoryId != null && selectedCategoryId!.isNotEmpty) {
      list = list.where((t) => t.categoryId == selectedCategoryId);
    }

    final out = list.toList();
    out.sort((a, b) {
      final ad = a.dueDate ?? DateTime(9999);
      final bd = b.dueDate ?? DateTime(9999);
      final cmp = ad.compareTo(bd);
      if (cmp != 0) return cmp;
      return b.createdAt.compareTo(a.createdAt);
    });
    return out;
  }

  String? getCategoryNameById(String? id) {
    if (id == null || id.isEmpty) return null;
    if (categoriesState is! SuccessState) return null;
    final list = (categoriesState as SuccessState).success;
    final cat = list.firstWhere(
      (c) => c.id == id,
      orElse: () => CategoryEntity(id: id, name: id),
    );
    return cat.name;
  }

  @action
  Future<void> loadAllData() async {
    categoriesState = LoadingState();
    tasksState = LoadingState();

    final results = await Future.wait([_allTasksUseCase(), _getAllCategoriesUseCase()]);

    final tasksResult = results[0] as Either<Failure, List<TaskEntity>>;
    final categoriesResult = results[1] as Either<Failure, List<CategoryEntity>>;
    tasksResult.fold((l) => tasksState = ErrorState(l), (r) {
      tasks = ObservableList.of(r);
      tasksState = SuccessState(r);
    });
    categoriesResult.fold((l) => categoriesState = ErrorState(l), (r) {
      categoriesState = SuccessState(r);
    });
  }

  // ----------------------------
  // Mutations (toggle done / update)
  // ----------------------------
  @action
  Future<void> setDone(String id, bool done) async {
    updateTaskState = LoadingState();
    final idx = tasks.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    tasks[idx] = tasks[idx].copyWith(done: done);
    final result = await _updateTaskFromIdUseCase(id, TaskModel.fromEntity(tasks[idx]));

    updateTaskState = result.fold((l) => ErrorState(l), (r) => SuccessState(null));
  }

  // ----------------------------
  // Multiple Selection
  // ----------------------------
  @observable
  ObservableSet<String> selectedTasksIDs = ObservableSet<String>();

  @observable
  bool isSelectionMode = false;

  @computed
  int get selectedCount => selectedTasksIDs.length;

  bool isSelected(String id) => selectedTasksIDs.contains(id);

  @action
  void startSelection(String id) {
    if (!isSelectionMode) isSelectionMode = true;
    selectedTasksIDs.add(id);
  }

  @action
  void toggleSelection(String id) {
    if (!isSelectionMode) return;
    if (!selectedTasksIDs.remove(id)) selectedTasksIDs.add(id);
    if (selectedTasksIDs.isEmpty) isSelectionMode = false;
  }

  @action
  void clearSelection() {
    selectedTasksIDs.clear();
    isSelectionMode = false;
  }

  // ----------------------------
  // Optimistic Exclusion + Undo
  // ----------------------------

  @action
  List<TaskEntity> removeByIdsOptimistic(Iterable<String> ids) {
    final idSet = ids.toSet();
    final removed = tasks.where((t) => idSet.contains(t.id)).toList(growable: false);
    tasks.removeWhere((t) => idSet.contains(t.id));
    clearSelection();
    return removed;
  }

  @action
  void restoreTasks(List<TaskEntity> items) {
    tasks.addAll(items);
    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @action
  Future<void> commitDeleteRange(Iterable<String> ids) async {
    deleteRangeState = LoadingState();
    final res = await _deleteFromIdRangeUseCase(ids);
    deleteRangeState = res.fold((f) => ErrorState(f), (_) => SuccessState(null));
  }

  @action
  TaskEntity? removeByIdOptimistic(String id) {
    final idx = tasks.indexWhere((t) => t.id == id);
    if (idx == -1) return null;
    final removed = tasks[idx];
    tasks.removeAt(idx);
    selectedTasksIDs.remove(id);
    if (selectedTasksIDs.isEmpty) isSelectionMode = false;
    return removed;
  }

  @action
  Future<void> commitDeleteOne(String id) async {
    deleteOneState = LoadingState();
    final res = await _deleteFromIdUseCase(id);
    deleteOneState = res.fold((f) => ErrorState(f), (_) => SuccessState(null));
  }
}
