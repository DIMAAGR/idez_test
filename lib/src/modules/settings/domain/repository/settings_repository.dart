import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../shared/data/models/settings_model.dart';

abstract class SettingsRepository {
  Future<Either<Failure, void>> saveSettingsData(SettingsModel settings);
  Future<Either<Failure, void>> clearAllData();
}
