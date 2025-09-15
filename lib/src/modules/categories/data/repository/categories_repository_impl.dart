import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';

import 'package:idez_test/src/modules/categories/data/models/category_model.dart';
import 'package:idez_test/src/modules/shared/data/data_source/task_local_data_source.dart';

import '../../domain/repository/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final TasksLocalDataSource local;

  CategoriesRepositoryImpl(this.local);

  @override
  Future<Either<Failure, void>> createCategory(CategoryModel category) async {
    try {
      final list = await local.getAllCategories();
      final exists = list.any((c) => c.id == category.id);
      if (exists) return Left(ValidationFailure('Category id already exists'));
      final next = [...list, category];
      await local.saveAllCategories(next);
      return Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to create category', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> updateCategoryFromId(String id, CategoryModel category) async {
    try {
      final list = await local.getAllCategories();
      final idx = list.indexWhere((c) => c.id == id);
      if (idx == -1) return Left(NotFoundFailure('Category not found'));
      list[idx] = category;
      await local.saveAllCategories(list);
      return Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to edit category', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategoryFromId(String id) async {
    try {
      final list = await local.getAllCategories();
      final filtered = list.where((c) => c.id != id).toList();
      await local.saveAllCategories(filtered);
      return Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to delete category', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategoryRangeFromId(Iterable<String> ids) async {
    try {
      final set = ids.toSet();
      final list = await local.getAllCategories();
      final filtered = list.where((c) => !set.contains(c.id)).toList();
      await local.saveAllCategories(filtered);
      return Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to delete categories', cause: e, stackTrace: s));
    }
  }
}
