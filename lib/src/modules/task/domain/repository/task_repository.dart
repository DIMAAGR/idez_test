import 'package:dartz/dartz.dart';
import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class TasksRepository {
  Future<Either<Failure, void>> createTask(TaskEntity task);
}
