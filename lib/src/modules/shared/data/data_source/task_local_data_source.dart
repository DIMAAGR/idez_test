import 'package:idez_test/src/modules/categories/data/models/category_model.dart';
import 'package:idez_test/src/modules/shared/data/models/task_model.dart';

abstract class TasksLocalDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<List<CategoryModel>> getAllCategories();
  Future<void> saveAllTasks(List<TaskModel> tasks);
  Future<void> saveAllCategories(List<CategoryModel> cats);
}
