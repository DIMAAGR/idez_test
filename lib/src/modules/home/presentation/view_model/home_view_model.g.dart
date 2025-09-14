// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
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

  late final _$_HomeViewModelBaseActionController = ActionController(
    name: '_HomeViewModelBase',
    context: context,
  );

  @override
  bool isSelected(String id) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.isSelected',
    );
    try {
      return super.isSelected(id);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void deleteSelectedTasks() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.deleteSelectedTasks',
    );
    try {
      return super.deleteSelectedTasks();
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
  void deleteTask(String id) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
      name: '_HomeViewModelBase.deleteTask',
    );
    try {
      return super.deleteTask(id);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTab: ${currentTab},
tasks: ${tasks},
selectedTasksIDs: ${selectedTasksIDs},
isSelectionMode: ${isSelectionMode},
doneTasks: ${doneTasks},
selectedCount: ${selectedCount},
tasksCount: ${tasksCount},
pendingTasksCount: ${pendingTasksCount},
overdueTasksCount: ${overdueTasksCount},
categoriesCount: ${categoriesCount}
    ''';
  }
}
