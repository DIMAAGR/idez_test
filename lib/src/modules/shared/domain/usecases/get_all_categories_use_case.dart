import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';
import '../repository/shared_repository.dart';

abstract class GetAllCategoriesUseCase {
  Future<Either<Failure, List<CategoryEntity>>> call();
}

class GetAllCategoriesUseCaseImpl implements GetAllCategoriesUseCase {
  final SharedRepository repository;

  GetAllCategoriesUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getAllCategories();
  }
}
