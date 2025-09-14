// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  Computed<List<TaskEntity>>? _$lastTasksComputed;

  @override
  List<TaskEntity> get lastTasks =>
      (_$lastTasksComputed ??= Computed<List<TaskEntity>>(
        () => super.lastTasks,
        name: '_HomeViewModelBase.lastTasks',
      )).value;
  Computed<List<TaskEntity>>? _$doneTasksComputed;

  @override
  List<TaskEntity> get doneTasks =>
      (_$doneTasksComputed ??= Computed<List<TaskEntity>>(
        () => super.doneTasks,
        name: '_HomeViewModelBase.doneTasks',
      )).value;
  Computed<int>? _$selectedCountComputed;

  @override
  int get selectedCount => (_$selectedCountComputed ??= Computed<int>(
    () => super.selectedCount,
    name: '_HomeViewModelBase.selectedCount',
  )).value;
  Computed<int>? _$tasksCountComputed;

  @override
  int get tasksCount => (_$tasksCountComputed ??= Computed<int>(
    () => super.tasksCount,
    name: '_HomeViewModelBase.tasksCount',
  )).value;
  Computed<int>? _$pendingTasksCountComputed;

  @override
  int get pendingTasksCount => (_$pendingTasksCountComputed ??= Computed<int>(
    () => super.pendingTasksCount,
    name: '_HomeViewModelBase.pendingTasksCount',
  )).value;
  Computed<int>? _$overdueTasksCountComputed;

  @override
  int get overdueTasksCount => (_$overdueTasksCountComputed ??= Computed<int>(
    () => super.overdueTasksCount,
    name: '_HomeViewModelBase.overdueTasksCount',
  )).value;
  Computed<int>? _$categoriesCountComputed;

  @override
  int get categoriesCount => (_$categoriesCountComputed ??= Computed<int>(
    () => super.categoriesCount,
    name: '_HomeViewModelBase.categoriesCount',
  )).value;

  late final _$tasksStateAtom = Atom(
    name: '_HomeViewModelBase.tasksState',
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
    name: '_HomeViewModelBase.categoriesState',
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

  late final _$doneTasksStateAtom = Atom(
    name: '_HomeViewModelBase.doneTasksState',
    context: context,
  );

  @override
  ViewModelState<Failure, List<TaskEntity>> get doneTasksState {
    _$doneTasksStateAtom.reportRead();
    return super.doneTasksState;
  }

  @override
  set doneTasksState(ViewModelState<Failure, List<TaskEntity>> value) {
    _$doneTasksStateAtom.reportWrite(value, super.doneTasksState, () {
      super.doneTasksState = value;
    });
  }

  late final _$deleteRangeStateAtom = Atom(
    name: '_HomeViewModelBase.deleteRangeState',
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
    name: '_HomeViewModelBase.deleteOneState',
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

  late final _$currentTabAtom = Atom(
    name: '_HomeViewModelBase.currentTab',
    context: context,
  );

  @override
  PillTab get currentTab {
    _$currentTabAtom.reportRead();
    return super.currentTab;
  }

  @override
  set currentTab(PillTab value) {
    _$currentTabAtom.reportWrite(value, super.currentTab, () {
      super.currentTab = value;
    });
  }

  late final _$tasksAtom = Atom(
    name: '_HomeViewModelBase.tasks',
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

  late final _$selectedTasksIDsAtom = Atom(
    name: '_HomeViewModelBase.selectedTasksIDs',
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
    name: '_HomeViewModelBase.isSelectionMode',
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

  late final _$commitDeleteRangeAsyncAction = AsyncAction(
    '_HomeViewModelBase.commitDeleteRange',
    context: context,
  );

  @override
  Future<void> commitDeleteRange(Iterable<String> ids) {
    return _$commitDeleteRangeAsyncAction.run(
      () => super.commitDeleteRange(ids),
    );
  }

  late final _$commitDeleteOneAsyncAction = AsyncAction(
    '_HomeViewModelBase.commitDeleteOne',
    context: context,
  );

  @override
  Future<void> commitDeleteOne(String id) {
    return _$commitDeleteOneAsyncAction.run(() => super.commitDeleteOne(id));
  }

  late final _$loadAllDataAsyncAction = AsyncAction(
    '_HomeViewModelBase.loadAllData',
    context: context,
  );

  @override
  Future<void> loadAllData() {
    return _$loadAllDataAsyncAction.run(() => super.loadAllData());
  }

  late final _$_HomeViewModelBaseActionController = ActionController(
    name: '_HomeViewModelBase',
    context: context,
  );

  @override
  void startSelection(String id) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.startSelection',
    );
    try {
      return super.startSelection(id);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSelection(String id) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.toggleSelection',
    );
    try {
      return super.toggleSelection(id);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelection() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.clearSelection',
    );
    try {
      return super.clearSelection();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<TaskEntity> removeByIdsOptimistic(Iterable<String> ids) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.removeByIdsOptimistic',
    );
    try {
      return super.removeByIdsOptimistic(ids);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restoreTasks(List<TaskEntity> items) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.restoreTasks',
    );
    try {
      return super.restoreTasks(items);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  TaskEntity? removeByIdOptimistic(String id) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.removeByIdOptimistic',
    );
    try {
      return super.removeByIdOptimistic(id);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDone(String id, bool done) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.setDone',
    );
    try {
      return super.setDone(id, done);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTask(
    String id, {
    String? title,
    String? categoryId,
    DateTime? dueDate,
  }) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.updateTask',
    );
    try {
      return super.updateTask(
        id,
        title: title,
        categoryId: categoryId,
        dueDate: dueDate,
      );
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tasksState: ${tasksState},
categoriesState: ${categoriesState},
doneTasksState: ${doneTasksState},
deleteRangeState: ${deleteRangeState},
deleteOneState: ${deleteOneState},
currentTab: ${currentTab},
tasks: ${tasks},
selectedTasksIDs: ${selectedTasksIDs},
isSelectionMode: ${isSelectionMode},
lastTasks: ${lastTasks},
doneTasks: ${doneTasks},
selectedCount: ${selectedCount},
tasksCount: ${tasksCount},
pendingTasksCount: ${pendingTasksCount},
overdueTasksCount: ${overdueTasksCount},
categoriesCount: ${categoriesCount}
    ''';
  }
}
