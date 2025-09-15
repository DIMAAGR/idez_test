// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoriesViewModel on _CategoriesViewModelBase, Store {
  Computed<int>? _$selectedCountComputed;

  @override
  int get selectedCount => (_$selectedCountComputed ??= Computed<int>(
    () => super.selectedCount,
    name: '_CategoriesViewModelBase.selectedCount',
  )).value;

  late final _$nameAtom = Atom(
    name: '_CategoriesViewModelBase.name',
    context: context,
  );

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$manageStateAtom = Atom(
    name: '_CategoriesViewModelBase.manageState',
    context: context,
  );

  @override
  ViewModelState<Failure, void> get manageState {
    _$manageStateAtom.reportRead();
    return super.manageState;
  }

  @override
  set manageState(ViewModelState<Failure, void> value) {
    _$manageStateAtom.reportWrite(value, super.manageState, () {
      super.manageState = value;
    });
  }

  late final _$categoriesStateAtom = Atom(
    name: '_CategoriesViewModelBase.categoriesState',
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
    name: '_CategoriesViewModelBase.deleteRangeState',
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
    name: '_CategoriesViewModelBase.deleteOneState',
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

  late final _$categoriesAtom = Atom(
    name: '_CategoriesViewModelBase.categories',
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

  late final _$selectedCategoriesIdsAtom = Atom(
    name: '_CategoriesViewModelBase.selectedCategoriesIds',
    context: context,
  );

  @override
  ObservableSet<String> get selectedCategoriesIds {
    _$selectedCategoriesIdsAtom.reportRead();
    return super.selectedCategoriesIds;
  }

  @override
  set selectedCategoriesIds(ObservableSet<String> value) {
    _$selectedCategoriesIdsAtom.reportWrite(
      value,
      super.selectedCategoriesIds,
      () {
        super.selectedCategoriesIds = value;
      },
    );
  }

  late final _$selectedTasksIDsAtom = Atom(
    name: '_CategoriesViewModelBase.selectedTasksIDs',
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
    name: '_CategoriesViewModelBase.isSelectionMode',
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

  late final _$createCategoryAsyncAction = AsyncAction(
    '_CategoriesViewModelBase.createCategory',
    context: context,
  );

  @override
  Future<void> createCategory() {
    return _$createCategoryAsyncAction.run(() => super.createCategory());
  }

  late final _$editCategoryAsyncAction = AsyncAction(
    '_CategoriesViewModelBase.editCategory',
    context: context,
  );

  @override
  Future<void> editCategory(String id) {
    return _$editCategoryAsyncAction.run(() => super.editCategory(id));
  }

  late final _$loadCategoriesAsyncAction = AsyncAction(
    '_CategoriesViewModelBase.loadCategories',
    context: context,
  );

  @override
  Future<void> loadCategories() {
    return _$loadCategoriesAsyncAction.run(() => super.loadCategories());
  }

  late final _$commitDeleteRangeAsyncAction = AsyncAction(
    '_CategoriesViewModelBase.commitDeleteRange',
    context: context,
  );

  @override
  Future<void> commitDeleteRange(Iterable<String> ids) {
    return _$commitDeleteRangeAsyncAction.run(
      () => super.commitDeleteRange(ids),
    );
  }

  late final _$commitDeleteOneAsyncAction = AsyncAction(
    '_CategoriesViewModelBase.commitDeleteOne',
    context: context,
  );

  @override
  Future<void> commitDeleteOne(String id) {
    return _$commitDeleteOneAsyncAction.run(() => super.commitDeleteOne(id));
  }

  late final _$_CategoriesViewModelBaseActionController = ActionController(
    name: '_CategoriesViewModelBase',
    context: context,
  );

  @override
  void startSelection(String id) {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
      name: '_CategoriesViewModelBase.startSelection',
    );
    try {
      return super.startSelection(id);
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSelection(String id) {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
      name: '_CategoriesViewModelBase.toggleSelection',
    );
    try {
      return super.toggleSelection(id);
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelection() {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
      name: '_CategoriesViewModelBase.clearSelection',
    );
    try {
      return super.clearSelection();
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<CategoryEntity> removeByIdsOptimistic(Iterable<String> ids) {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
      name: '_CategoriesViewModelBase.removeByIdsOptimistic',
    );
    try {
      return super.removeByIdsOptimistic(ids);
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restoreCategories(List<CategoryEntity> items) {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
      name: '_CategoriesViewModelBase.restoreCategories',
    );
    try {
      return super.restoreCategories(items);
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  CategoryEntity? removeByIdOptimistic(String id) {
    final _$actionInfo = _$_CategoriesViewModelBaseActionController.startAction(
      name: '_CategoriesViewModelBase.removeByIdOptimistic',
    );
    try {
      return super.removeByIdOptimistic(id);
    } finally {
      _$_CategoriesViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
manageState: ${manageState},
categoriesState: ${categoriesState},
deleteRangeState: ${deleteRangeState},
deleteOneState: ${deleteOneState},
categories: ${categories},
selectedCategoriesIds: ${selectedCategoriesIds},
selectedTasksIDs: ${selectedTasksIDs},
isSelectionMode: ${isSelectionMode},
selectedCount: ${selectedCount}
    ''';
  }
}
