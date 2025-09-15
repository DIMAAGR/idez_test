import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/categories_repository.dart';

abstract class DeleteCategoryFromIdRangeUseCase {
  Future<Either<Failure, void>> call(Iterable<String> ids);
}

class DeleteCategoryFromIdRangeUseCaseImpl implements DeleteCategoryFromIdRangeUseCase {
  final CategoriesRepository _repository;

  DeleteCategoryFromIdRangeUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, void>> call(Iterable<String> ids) async {
    return await _repository.deleteCategoryRangeFromId(ids);
  }
}
