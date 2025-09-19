import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/settings_entity.dart';
import '../repository/shared_repository.dart';

abstract class GetSettingsDataUseCase {
  Future<Either<Failure, SettingsEntity>> call();
}

class GetSettingsDataUseCaseImpl implements GetSettingsDataUseCase {
  final SharedRepository repository;

  GetSettingsDataUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, SettingsEntity>> call() {
    return repository.getSettingsData();
  }
}
