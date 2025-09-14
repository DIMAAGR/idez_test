import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/task_model.dart';
import '../repository/task_repository.dart';

abstract class CreateTaskUseCase {
  Future<Either<Failure, void>> call(TaskModel task);
}

class CreateTaskUseCaseImpl implements CreateTaskUseCase {
  final TasksRepository repository;

  CreateTaskUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(TaskModel task) {
    return repository.createTask(task);
  }
}
