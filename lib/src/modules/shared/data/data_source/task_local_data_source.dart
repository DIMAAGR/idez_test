import '../../../categories/data/models/category_model.dart';
import '../models/settings_model.dart';
import '../models/task_model.dart';

abstract class TasksLocalDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<List<CategoryModel>> getAllCategories();
  Future<SettingsModel> getSettingsData();
  Future<void> saveAllTasks(List<TaskModel> tasks);
  Future<void> saveAllCategories(List<CategoryModel> cats);
}
