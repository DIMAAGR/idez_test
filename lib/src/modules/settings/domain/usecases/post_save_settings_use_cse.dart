import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../shared/data/models/settings_model.dart';
import '../repository/settings_repository.dart';

abstract class PostSaveSettingsUseCse {
  Future<Either<Failure, void>> call(SettingsModel settings);
}

class PostSaveSettingsUseCseImpl implements PostSaveSettingsUseCse {
  final SettingsRepository repository;

  PostSaveSettingsUseCseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(SettingsModel settings) {
    return repository.saveSettingsData(settings);
  }
}
