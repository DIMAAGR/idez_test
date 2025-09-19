import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';
import '../entities/settings_entity.dart';
import '../entities/task_entity.dart';

abstract class SharedRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
  Future<Either<Failure, List<TaskEntity>>> getAllDoneTasks();
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, SettingsEntity>> getSettingsData();
  Future<Either<Failure, void>> deleteFromId(String id);
  Future<Either<Failure, void>> deleteFromIdRange(Iterable<String> ids);
  Future<Either<Failure, void>> updateFromId(String id, TaskEntity task);
  Future<Either<Failure, bool>> getNotificationEnabled();
}
