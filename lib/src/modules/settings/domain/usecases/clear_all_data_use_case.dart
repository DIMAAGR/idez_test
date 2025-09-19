import 'package:dartz/dartz.dart';
import 'package:idez_test/src/core/errors/failure.dart';

import '../repository/settings_repository.dart';

abstract class ClearAllDataUseCase {
  Future<Either<Failure, void>> call();
}

class ClearAllDataUseCaseImpl implements ClearAllDataUseCase {
  final SettingsRepository _repository;

  ClearAllDataUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, void>> call() {
    return _repository.clearAllData();
  }
}
