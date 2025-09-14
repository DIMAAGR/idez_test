import 'package:dartz/dartz.dart';
import 'package:idez_test/src/core/errors/failure.dart';

import '../repository/shared_repository.dart';

abstract class DeleteFromIdRangeUseCase {
  Future<Either<Failure, void>> call(Iterable<String> ids);
}

class DeleteFromIdRangeUseCaseImpl implements DeleteFromIdRangeUseCase {
  final SharedRepository repository;

  DeleteFromIdRangeUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(Iterable<String> ids) {
    return repository.deleteFromIdRange(ids);
  }
}
