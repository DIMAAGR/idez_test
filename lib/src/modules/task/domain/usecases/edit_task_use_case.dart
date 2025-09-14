import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/task_model.dart';
import '../repository/task_repository.dart';

abstract class EditTaskUseCase {
  Future<Either<Failure, void>> call(String id, TaskModel task);
}

class EditTaskUseCaseImpl implements EditTaskUseCase {
  final TasksRepository repository;

  EditTaskUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(String id, TaskModel task) {
    return repository.editTask(id, task);
  }
}
