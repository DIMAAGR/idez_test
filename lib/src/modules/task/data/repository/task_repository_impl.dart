import 'package:dartz/dartz.dart';
import 'package:idez_test/src/modules/task/domain/repository/task_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../shared/data/data_source/task_local_data_source.dart';
import '../../../shared/data/models/task_model.dart';

class TaskRepositoryImpl implements TasksRepository {
  final TasksLocalDataSource local;

  TaskRepositoryImpl(this.local);

  @override
  Future<Either<Failure, void>> createTask(TaskModel task) async {
    try {
      final list = await local.getAllTasks();
      final exists = list.any((t) => t.id == task.id);
      if (exists) return Left(ValidationFailure('Task id already exists'));
      final next = [...list, task];
      await local.saveAllTasks(next);
      return Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to create task', cause: e, stackTrace: s));
    }
  }
}
