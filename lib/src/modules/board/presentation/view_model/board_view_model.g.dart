// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BoardViewModel on _BoardViewModel, Store {
  Computed<bool>? _$hasActiveFiltersComputed;

  @override
  bool get hasActiveFilters => (_$hasActiveFiltersComputed ??= Computed<bool>(
    () => super.hasActiveFilters,
    name: '_BoardViewModel.hasActiveFilters',
  )).value;
  Computed<List<TaskEntity>>? _$visibleTasksComputed;

  @override
  List<TaskEntity> get visibleTasks =>
      (_$visibleTasksComputed ??= Computed<List<TaskEntity>>(
        () => super.visibleTasks,
        name: '_BoardViewModel.visibleTasks',
      )).value;
  Computed<int>? _$selectedCountComputed;

  @override
  int get selectedCount => (_$selectedCountComputed ??= Computed<int>(
    () => super.selectedCount,
    name: '_BoardViewModel.selectedCount',
  )).value;

  late final _$boardTypeAtom = Atom(
    name: '_BoardViewModel.boardType',
    context: context,
  );

  @override
  BoardType get boardType {
    _$boardTypeAtom.reportRead();
    return super.boardType;
  }

  @override
  set boardType(BoardType value) {
    _$boardTypeAtom.reportWrite(value, super.boardType, () {
      super.boardType = value;
    });
  }

  late final _$tasksStateAtom = Atom(
    name: '_BoardViewModel.tasksState',
    context: context,
  );

  @override
  ViewModelState<Failure, List<TaskEntity>> get tasksState {
    _$tasksStateAtom.reportRead();
    return super.tasksState;
  }

  @override
  set tasksState(ViewModelState<Failure, List<TaskEntity>> value) {
    _$tasksStateAtom.reportWrite(value, super.tasksState, () {
      super.tasksState = value;
    });
  }

  late final _$categoriesStateAtom = Atom(
    name: '_BoardViewModel.categoriesState',
    context: context,
  );

  @override
  ViewModelState<Failure, List<CategoryEntity>> get categoriesState {
    _$categoriesStateAtom.reportRead();
    return super.categoriesState;
  }

  @override
  set categoriesState(ViewModelState<Failure, List<CategoryEntity>> value) {
    _$categoriesStateAtom.reportWrite(value, super.categoriesState, () {
      super.categoriesState = value;
    });
  }

  late final _$deleteRangeStateAtom = Atom(
    name: '_BoardViewModel.deleteRangeState',
    context: context,
  );

  @override
  ViewModelState<Failure, void> get deleteRangeState {
    _$deleteRangeStateAtom.reportRead();
    return super.deleteRangeState;
  }

  @override
  set deleteRangeState(ViewModelState<Failure, void> value) {
    _$deleteRangeStateAtom.reportWrite(value, super.deleteRangeState, () {
      super.deleteRangeState = value;
    });
  }

  late final _$deleteOneStateAtom = Atom(
    name: '_BoardViewModel.deleteOneState',
    context: context,
  );

  @override
  ViewModelState<Failure, void> get deleteOneState {
    _$deleteOneStateAtom.reportRead();
    return super.deleteOneState;
  }

  @override
  set deleteOneState(ViewModelState<Failure, void> value) {
    _$deleteOneStateAtom.reportWrite(value, super.deleteOneState, () {
      super.deleteOneState = value;
    });
  }

  late final _$updateTaskStateAtom = Atom(
    name: '_BoardViewModel.updateTaskState',
    context: context,
  );

  @override
  ViewModelState<Failure, void> get updateTaskState {
    _$updateTaskStateAtom.reportRead();
    return super.updateTaskState;
  }

  @override
  set updateTaskState(ViewModelState<Failure, void> value) {
    _$updateTaskStateAtom.reportWrite(value, super.updateTaskState, () {
      super.updateTaskState = value;
    });
  }

  late final _$tasksAtom = Atom(
    name: '_BoardViewModel.tasks',
    context: context,
  );

  @override
  ObservableList<TaskEntity> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<TaskEntity> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$filterAtom = Atom(
    name: '_BoardViewModel.filter',
    context: context,
  );

  @override
  TaskFilter get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(TaskFilter value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$selectedCategoryIdAtom = Atom(
    name: '_BoardViewModel.selectedCategoryId',
    context: context,
  );

  @override
  String? get selectedCategoryId {
    _$selectedCategoryIdAtom.reportRead();
    return super.selectedCategoryId;
  }

  @override
  set selectedCategoryId(String? value) {
    _$selectedCategoryIdAtom.reportWrite(value, super.selectedCategoryId, () {
      super.selectedCategoryId = value;
    });
  }

  late final _$selectedTasksIDsAtom = Atom(
    name: '_BoardViewModel.selectedTasksIDs',
    context: context,
  );

  @override
  ObservableSet<String> get selectedTasksIDs {
    _$selectedTasksIDsAtom.reportRead();
    return super.selectedTasksIDs;
  }

  @override
  set selectedTasksIDs(ObservableSet<String> value) {
    _$selectedTasksIDsAtom.reportWrite(value, super.selectedTasksIDs, () {
      super.selectedTasksIDs = value;
    });
  }

  late final _$isSelectionModeAtom = Atom(
    name: '_BoardViewModel.isSelectionMode',
    context: context,
  );

  @override
  bool get isSelectionMode {
    _$isSelectionModeAtom.reportRead();
    return super.isSelectionMode;
  }

  @override
  set isSelectionMode(bool value) {
    _$isSelectionModeAtom.reportWrite(value, super.isSelectionMode, () {
      super.isSelectionMode = value;
    });
  }

  late final _$loadAllDataAsyncAction = AsyncAction(
    '_BoardViewModel.loadAllData',
    context: context,
  );

  @override
  Future<void> loadAllData() {
    return _$loadAllDataAsyncAction.run(() => super.loadAllData());
  }

  late final _$setDoneAsyncAction = AsyncAction(
    '_BoardViewModel.setDone',
    context: context,
  );

  @override
  Future<void> setDone(String id, bool done) {
    return _$setDoneAsyncAction.run(() => super.setDone(id, done));
  }

  late final _$commitDeleteRangeAsyncAction = AsyncAction(
    '_BoardViewModel.commitDeleteRange',
    context: context,
  );

  @override
  Future<void> commitDeleteRange(Iterable<String> ids) {
    return _$commitDeleteRangeAsyncAction.run(
      () => super.commitDeleteRange(ids),
    );
  }

  late final _$commitDeleteOneAsyncAction = AsyncAction(
    '_BoardViewModel.commitDeleteOne',
    context: context,
  );

  @override
  Future<void> commitDeleteOne(String id) {
    return _$commitDeleteOneAsyncAction.run(() => super.commitDeleteOne(id));
  }

  late final _$_BoardViewModelActionController = ActionController(
    name: '_BoardViewModel',
    context: context,
  );

  @override
  void loadBoard(String? type) {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.loadBoard',
    );
    try {
      return super.loadBoard(type);
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(TaskFilter f) {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.setFilter',
    );
    try {
      return super.setFilter(f);
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(String? id) {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.setCategory',
    );
    try {
      return super.setCategory(id);
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.clearFilters',
    );
    try {
      return super.clearFilters();
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startSelection(String id) {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.startSelection',
    );
    try {
      return super.startSelection(id);
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSelection(String id) {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.toggleSelection',
    );
    try {
      return super.toggleSelection(id);
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelection() {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.clearSelection',
    );
    try {
      return super.clearSelection();
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<TaskEntity> removeByIdsOptimistic(Iterable<String> ids) {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.removeByIdsOptimistic',
    );
    try {
      return super.removeByIdsOptimistic(ids);
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restoreTasks(List<TaskEntity> items) {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.restoreTasks',
    );
    try {
      return super.restoreTasks(items);
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  TaskEntity? removeByIdOptimistic(String id) {
    final _$actionInfo = _$_BoardViewModelActionController.startAction(
      name: '_BoardViewModel.removeByIdOptimistic',
    );
    try {
      return super.removeByIdOptimistic(id);
    } finally {
      _$_BoardViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
boardType: ${boardType},
tasksState: ${tasksState},
categoriesState: ${categoriesState},
deleteRangeState: ${deleteRangeState},
deleteOneState: ${deleteOneState},
updateTaskState: ${updateTaskState},
tasks: ${tasks},
filter: ${filter},
selectedCategoryId: ${selectedCategoryId},
selectedTasksIDs: ${selectedTasksIDs},
isSelectionMode: ${isSelectionMode},
hasActiveFilters: ${hasActiveFilters},
visibleTasks: ${visibleTasks},
selectedCount: ${selectedCount}
    ''';
  }
}
