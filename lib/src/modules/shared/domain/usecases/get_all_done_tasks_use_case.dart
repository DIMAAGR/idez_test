import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/task_entity.dart';
import '../repository/shared_repository.dart';

abstract class GetAllDoneTasksUseCase {
  Future<Either<Failure, List<TaskEntity>>> call();
}

class GetAllDoneTasksUseCaseImpl implements GetAllDoneTasksUseCase {
  final SharedRepository repository;

  GetAllDoneTasksUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call() {
    return repository.getAllDoneTasks();
  }
}
