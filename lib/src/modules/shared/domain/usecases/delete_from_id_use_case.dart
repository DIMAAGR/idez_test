import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/shared_repository.dart';

abstract class DeleteFromIdUseCase {
  Future<Either<Failure, void>> call(String id);
}

class DeleteFromIdUseCaseImpl implements DeleteFromIdUseCase {
  final SharedRepository repository;

  DeleteFromIdUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return repository.deleteFromId(id);
  }
}
