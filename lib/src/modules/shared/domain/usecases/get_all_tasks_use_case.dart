import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/task_entity.dart';
import '../repository/shared_repository.dart';

abstract class GetAllTasksUseCase {
  Future<Either<Failure, List<TaskEntity>>> call();
}

class GetAllTasksUseCaseImpl implements GetAllTasksUseCase {
  final SharedRepository repository;

  GetAllTasksUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call() {
    return repository.getAllTasks();
  }
}
