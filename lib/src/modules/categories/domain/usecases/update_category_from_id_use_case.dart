import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/category_model.dart';
import '../repository/categories_repository.dart';

abstract class UpdateCategoryFromIdUseCase {
  Future<Either<Failure, void>> call(String id, CategoryModel category);
}

class UpdateCategoryFromIdUseCaseImpl implements UpdateCategoryFromIdUseCase {
  final CategoriesRepository _repository;

  UpdateCategoryFromIdUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, void>> call(String id, CategoryModel category) {
    return _repository.updateCategoryFromId(id, category);
  }
}
