import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/category_model.dart';
import '../repository/categories_repository.dart';

abstract class CreateCategoryUseCase {
  Future<Either<Failure, void>> call(CategoryModel category);
}

class CreateCategoryUseCaseImpl implements CreateCategoryUseCase {
  final CategoriesRepository _repository;

  CreateCategoryUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, void>> call(CategoryModel category) {
    return _repository.createCategory(category);
  }
}
