import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../shared/domain/entities/task_entity.dart';
import '../../../shared/domain/services/reminder_policy.dart';
import '../repository/task_repository.dart';

abstract class CreateTaskUseCase {
  Future<Either<Failure, void>> call(TaskEntity task);
}

class CreateTaskUseCaseImpl implements CreateTaskUseCase {
  final TasksRepository repository;
  final ReminderPolicy policy;

  CreateTaskUseCaseImpl(this.repository, this.policy);

  @override
  Future<Either<Failure, Unit>> call(TaskEntity task) async {
    final res = await repository.createTask(task);
    if (res.isLeft()) return res.map((_) => unit);
    return policy.afterCreate(task);
  }
}
