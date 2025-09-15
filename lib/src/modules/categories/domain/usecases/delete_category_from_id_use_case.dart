import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/categories_repository.dart';

abstract class DeleteCategoryFromIdUseCase {
  Future<Either<Failure, void>> call(String id);
}

class DeleteCategoryFromIdUseCaseImpl implements DeleteCategoryFromIdUseCase {
  final CategoriesRepository _repository;

  DeleteCategoryFromIdUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await _repository.deleteCategoryFromId(id);
  }
}
