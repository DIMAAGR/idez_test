import 'package:idez_test/src/modules/shared/data/models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<void> saveSettingsData(SettingsModel settings);
  Future<void> clearAllData();
}
