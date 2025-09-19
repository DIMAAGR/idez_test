// test/helpers/fakes.dart
import 'package:idez_test/src/modules/shared/data/models/settings_model.dart';
import 'package:idez_test/src/modules/shared/data/models/task_model.dart';
import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';
import 'package:idez_test/src/modules/shared/domain/enums/selected_theme_enum.dart';

TaskModel tModel(String id, {bool done = false}) => TaskModel(
  id: id,
  title: 't$id',
  done: done,
  createdAt: DateTime(2024, 1, 1).toIso8601String(),
  dueDate: null,
  categoryId: null,
);

SettingsModel tSettingsModel({
  bool isNotificationEnabled = false,
  SelectedTheme selectedTheme = SelectedTheme.system,
}) => SettingsModel(
  isNotificationEnabled: isNotificationEnabled,
  selectedTheme: selectedTheme,
  isPasswordEnabled: false,
  listSize: 10,
);

TaskEntity tEntity(String id, {bool done = false}) => TaskEntity(
  id: id,
  title: 't$id',
  done: done,
  createdAt: DateTime(2024, 1, 1),
  dueDate: null,
  categoryId: null,
);
