import 'dart:convert';

import 'package:idez_test/src/core/schema/storage_schema.dart';
import 'package:idez_test/src/modules/shared/data/models/settings_model.dart';

import '../../../../core/storage/wrapper.dart';
import '../models/task_model.dart';
import '../../../categories/data/models/category_model.dart';
import 'task_local_data_source.dart';

class TasksLocalDataSourceImpl implements TasksLocalDataSource {
  final KeyValueStore store;
  TasksLocalDataSourceImpl(this.store);

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final raw = store.getString(StorageSchema.tasksKey);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(TaskModel.fromJson).toList();
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final raw = store.getString(StorageSchema.categoriesKey);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(CategoryModel.fromJson).toList();
  }

  @override
  Future<void> saveAllTasks(List<TaskModel> tasks) async {
    final encoded = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await store.setString(StorageSchema.tasksKey, encoded);
  }

  @override
  Future<void> saveAllCategories(List<CategoryModel> cats) async {
    final encoded = jsonEncode(cats.map((e) => e.toJson()).toList());
    await store.setString(StorageSchema.categoriesKey, encoded);
  }

  @override
  Future<SettingsModel> getSettingsData() async {
    final raw = store.getString(StorageSchema.settingsKey);
    if (raw == null) {
      return SettingsModel.defaultSettings();
    }
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return SettingsModel.fromJson(map);
  }
}
