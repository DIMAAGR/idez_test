import 'package:idez_test/src/modules/shared/domain/usecases/update_task_from_id_use_case.dart';
import 'package:mobx/mobx.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/state/view_model_state.dart';
import '../../../shared/data/models/task_model.dart';
import '../../../shared/domain/entities/task_entity.dart';
import '../../../shared/domain/entities/category_entity.dart';

// use cases
import '../../../shared/domain/usecases/get_all_tasks_use_case.dart';
import '../../../shared/domain/usecases/get_all_done_tasks_use_case.dart';
import '../../../shared/domain/usecases/get_all_categories_use_case.dart';
import '../../../shared/domain/usecases/delete_from_id_use_case.dart';
import '../../../shared/domain/usecases/delete_from_id_range_use_case.dart';

import '../models/pill_tab_enum.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final GetAllCategoriesUseCase _allCategoriesUseCase;
  final GetAllDoneTasksUseCase _allDoneTasksUseCase;
  final GetAllTasksUseCase _allTasksUseCase;
  final DeleteFromIdUseCase _deleteFromIdUseCase;
  final DeleteFromIdRangeUseCase _deleteFromIdRangeUseCase;
  final UpdateTaskFromIdUseCase _updateTaskFromIdUseCase;

  _HomeViewModelBase(
    this._allCategoriesUseCase,
    this._allDoneTasksUseCase,
    this._allTasksUseCase,
    this._deleteFromIdUseCase,
    this._deleteFromIdRangeUseCase,
    this._updateTaskFromIdUseCase,
  );

  // ----------------------------
  // States and Results
  // ----------------------------
  @observable
  ViewModelState<Failure, List<TaskEntity>> tasksState = InitialState();

  @observable
  ViewModelState<Failure, List<CategoryEntity>> categoriesState = InitialState();

  @observable
  ViewModelState<Failure, List<TaskEntity>> doneTasksState = InitialState();

  @observable
  ViewModelState<Failure, void> deleteRangeState = InitialState();

  @observable
  ViewModelState<Failure, void> deleteOneState = InitialState();
  @observable
  ViewModelState<Failure, void> updateTaskState = InitialState();

  // ----------------------------
  // Navigation
  // ----------------------------
  @observable
  PillTab currentTab = PillTab.home;

  // ----------------------------
  // Collections
  // ----------------------------
  @observable
  ObservableList<TaskEntity> tasks = ObservableList.of([]);

  @computed
  List<TaskEntity> get lastTasks {
    final sorted = [...tasks]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(10).toList(growable: false);
  }

  @computed
  List<TaskEntity> get doneTasks {
    final list = tasks.where((t) => t.done).toList(growable: false);
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
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
  // Counts
  // ----------------------------
  @computed
  int get tasksCount => tasks.length;

  @computed
  int get overdueTasksCount {
    final now = DateTime.now();

    return tasks.where((t) => !t.done && t.dueDate != null && t.dueDate!.isBefore(now)).length;
  }

  @computed
  int get pendingTasksCount {
    final now = DateTime.now();

    return tasks.where((t) => !t.done && (t.dueDate == null || t.dueDate!.isAfter(now))).length;
  }

  @computed
  int get categoriesCount {
    final set = <String>{};

    if (categoriesState is! SuccessState) return 0;

    for (final t in (categoriesState as SuccessState).success) {
      final c = t.id;
      if (c != null && c.isNotEmpty) set.add(c);
    }
    return set.length;
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

  // ----------------------------
  // Initial Setup
  // ----------------------------
  @action
  Future<void> loadAllData() async {
    tasksState = LoadingState();
    categoriesState = LoadingState();
    doneTasksState = LoadingState();

    final results = await Future.wait([
      _allTasksUseCase(),
      _allCategoriesUseCase(),
      _allDoneTasksUseCase(),
    ]);

    final tasksResult = results[0] as Either<Failure, List<TaskEntity>>;
    final categoriesResult = results[1] as Either<Failure, List<CategoryEntity>>;
    final doneResult = results[2] as Either<Failure, List<TaskEntity>>;

    tasksResult.fold((l) => tasksState = ErrorState(l), (r) {
      tasks = ObservableList.of(r);
      tasksState = SuccessState(r);
    });

    categoriesResult.fold(
      (l) => categoriesState = ErrorState(l),
      (r) => categoriesState = SuccessState(r),
    );

    doneResult.fold((l) => doneTasksState = ErrorState(l), (r) => doneTasksState = SuccessState(r));
  }
}
