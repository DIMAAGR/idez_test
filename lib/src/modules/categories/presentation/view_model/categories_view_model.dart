import 'package:flutter/material.dart';
import 'package:idez_test/src/modules/categories/domain/usecases/delete_category_from_id_range_use_case.dart';
import 'package:idez_test/src/modules/shared/domain/entities/category_entity.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_all_categories_use_case.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/state/view_model_state.dart';
import '../../data/models/category_model.dart';
import '../../domain/usecases/create_category_use_case.dart';
import '../../domain/usecases/delete_category_from_id_use_case.dart';
import '../../domain/usecases/update_category_from_id_use_case.dart';

part 'categories_view_model.g.dart';

class CategoriesViewModel = _CategoriesViewModelBase with _$CategoriesViewModel;

abstract class _CategoriesViewModelBase with Store {
  final CreateCategoryUseCase _createCategoryUseCase;
  final UpdateCategoryFromIdUseCase _updateCategoryFromIdUseCase;
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  final DeleteCategoryFromIdUseCase _deleteFromIdUseCase;
  final DeleteCategoryFromIdRangeUseCase _deleteFromIdRangeUseCase;

  _CategoriesViewModelBase(
    this._createCategoryUseCase,
    this._updateCategoryFromIdUseCase,
    this._getAllCategoriesUseCase,
    this._deleteFromIdUseCase,
    this._deleteFromIdRangeUseCase,
  );

  @observable
  String name = '';

  @observable
  ViewModelState<Failure, void> manageState = InitialState();

  @observable
  ViewModelState<Failure, List<CategoryEntity>> categoriesState = InitialState();

  @observable
  ViewModelState<Failure, void> deleteRangeState = InitialState();

  @observable
  ViewModelState<Failure, void> deleteOneState = InitialState();

  // ----- Data -----

  @observable
  ObservableList<CategoryEntity> categories = ObservableList.of([]);

  @observable
  ObservableSet<String> selectedCategoriesIds = ObservableSet<String>();

  @action
  Future<void> createCategory() async {
    manageState = LoadingState();
    final model = CategoryModel(id: UniqueKey().toString(), name: name);
    final result = await _createCategoryUseCase(model);
    manageState = result.fold((failure) => ErrorState(failure), (_) => SuccessState(null));
  }

  @action
  Future<void> editCategory(String id) async {
    manageState = LoadingState();
    final result = await _updateCategoryFromIdUseCase(id, CategoryModel(id: id, name: name));
    manageState = result.fold((failure) => ErrorState(failure), (_) => SuccessState(null));
  }

  @action
  Future<void> loadCategories() async {
    categoriesState = LoadingState();
    final result = await _getAllCategoriesUseCase();
    categoriesState = result.fold(
      (failure) => ErrorState(failure),
      (categories) => SuccessState(categories),
    );

    categories = ObservableList.of(result.getOrElse(() => []));
    categories.sort((a, b) => b.name.compareTo(a.name));
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
  List<CategoryEntity> removeByIdsOptimistic(Iterable<String> ids) {
    final idSet = ids.toSet();
    final removed = categories.where((t) => idSet.contains(t.id)).toList(growable: false);
    categories.removeWhere((t) => idSet.contains(t.id));
    clearSelection();
    return removed;
  }

  @action
  void restoreCategories(List<CategoryEntity> items) {
    categories.addAll(items);
    categories.sort((a, b) => b.name.compareTo(a.name));
  }

  @action
  Future<void> commitDeleteRange(Iterable<String> ids) async {
    deleteRangeState = LoadingState();
    final res = await _deleteFromIdRangeUseCase(ids);
    deleteRangeState = res.fold((f) => ErrorState(f), (_) => SuccessState(null));
  }

  @action
  CategoryEntity? removeByIdOptimistic(String id) {
    final idx = categories.indexWhere((t) => t.id == id);
    if (idx == -1) return null;
    final removed = categories[idx];
    categories.removeAt(idx);
    selectedCategoriesIds.remove(id);
    if (selectedCategoriesIds.isEmpty) isSelectionMode = false;
    return removed;
  }

  @action
  Future<void> commitDeleteOne(String id) async {
    deleteOneState = LoadingState();
    final res = await _deleteFromIdUseCase(id);
    deleteOneState = res.fold((f) => ErrorState(f), (_) => SuccessState(null));
  }
}
