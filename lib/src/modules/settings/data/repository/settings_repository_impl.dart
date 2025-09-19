import 'package:dartz/dartz.dart';
import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/settings/domain/repository/settings_repository.dart';
import 'package:idez_test/src/modules/shared/data/models/settings_model.dart';

import '../../domain/datasource/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, void>> saveSettingsData(SettingsModel settings) async {
    try {
      await _localDataSource.saveSettingsData(settings);
      return const Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to save settings', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> clearAllData() {
    try {
      return _localDataSource.clearAllData().then((_) => const Right(null));
    } catch (e, s) {
      return Future.value(
        Left(StorageFailure('Failed to clear all data', cause: e, stackTrace: s)),
      );
    }
  }
}
