import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../shared/data/models/settings_model.dart';
import '../repository/settings_repository.dart';

abstract class PostSaveSettingsUseCase {
  Future<Either<Failure, void>> call(SettingsModel settings);
}

class PostSaveSettingsUseCaseImpl implements PostSaveSettingsUseCase {
  final SettingsRepository repository;

  PostSaveSettingsUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(SettingsModel settings) {
    return repository.saveSettingsData(settings);
  }
}
