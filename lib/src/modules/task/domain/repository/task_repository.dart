import 'package:dartz/dartz.dart';
import 'package:idez_test/src/modules/task/data/models/task_model.dart';

import '../../../../core/errors/failure.dart';

abstract class TasksRepository {
  Future<Either<Failure, void>> createTask(TaskModel task);
  Future<Either<Failure, void>> editTask(String id, TaskModel task);
}
