import 'dart:convert';

import 'package:idez_test/src/modules/settings/domain/datasource/settings_local_data_source.dart';
import 'package:idez_test/src/modules/shared/data/models/settings_model.dart';

import '../../../../core/schema/storage_schema.dart';
import '../../../../core/storage/wrapper.dart';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final KeyValueStore store;
  SettingsLocalDataSourceImpl(this.store);
  @override
  Future<void> saveSettingsData(SettingsModel settings) {
    final encoded = jsonEncode(settings.toJson());
    return store.setString(StorageSchema.settingsKey, encoded);
  }

  @override
  Future<void> clearAllData() async {
    await store.remove(StorageSchema.settingsKey);
    await store.remove(StorageSchema.tasksKey);
    await store.remove(StorageSchema.categoriesKey);
  }
}
