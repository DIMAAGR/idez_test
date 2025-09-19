// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskViewModel on _TaskViewModelBase, Store {
  late final _$selectedCategoryIdAtom = Atom(
    name: '_TaskViewModelBase.selectedCategoryId',
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

  late final _$categoriesAtom = Atom(
    name: '_TaskViewModelBase.categories',
    context: context,
  );

  @override
  ObservableList<CategoryEntity> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<CategoryEntity> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$stateAtom = Atom(
    name: '_TaskViewModelBase.state',
    context: context,
  );

  @override
  ViewModelState<Failure, void> get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ViewModelState<Failure, void> value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$categoriesStateAtom = Atom(
    name: '_TaskViewModelBase.categoriesState',
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

  late final _$loadCategoriesAsyncAction = AsyncAction(
    '_TaskViewModelBase.loadCategories',
    context: context,
  );

  @override
  Future<void> loadCategories() {
    return _$loadCategoriesAsyncAction.run(() => super.loadCategories());
  }

  late final _$createTaskAsyncAction = AsyncAction(
    '_TaskViewModelBase.createTask',
    context: context,
  );

  @override
  Future<void> createTask() {
    return _$createTaskAsyncAction.run(() => super.createTask());
  }

  late final _$editTaskAsyncAction = AsyncAction(
    '_TaskViewModelBase.editTask',
    context: context,
  );

  @override
  Future<void> editTask({
    required String id,
    required DateTime originalCreatedAt,
    bool preserveDone = true,
    bool originalDoneValue = false,
  }) {
    return _$editTaskAsyncAction.run(
      () => super.editTask(
        id: id,
        originalCreatedAt: originalCreatedAt,
        preserveDone: preserveDone,
        originalDoneValue: originalDoneValue,
      ),
    );
  }

  late final _$_TaskViewModelBaseActionController = ActionController(
    name: '_TaskViewModelBase',
    context: context,
  );

  @override
  void setCategory(String? id) {
    final _$actionInfo = _$_TaskViewModelBaseActionController.startAction(
      name: '_TaskViewModelBase.setCategory',
    );
    try {
      return super.setCategory(id);
    } finally {
      _$_TaskViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategoryId: ${selectedCategoryId},
categories: ${categories},
state: ${state},
categoriesState: ${categoriesState}
    ''';
  }
}
