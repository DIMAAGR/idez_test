import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/category_model.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, void>> createCategory(CategoryModel category);
  Future<Either<Failure, void>> updateCategoryFromId(String id, CategoryModel category);
  Future<Either<Failure, void>> deleteCategoryFromId(String id);
  Future<Either<Failure, void>> deleteCategoryRangeFromId(Iterable<String> ids);
}
