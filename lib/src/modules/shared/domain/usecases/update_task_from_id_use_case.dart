import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/task_entity.dart';
import '../repository/shared_repository.dart';
import '../services/reminder_policy.dart';

abstract class UpdateTaskFromIdUseCase {
  Future<Either<Failure, void>> call(String id, TaskEntity data);
}

class UpdateTaskFromIdUseCaseImpl implements UpdateTaskFromIdUseCase {
  final SharedRepository repository;
  final ReminderPolicy policy;

  UpdateTaskFromIdUseCaseImpl(this.repository, this.policy);

  @override
  Future<Either<Failure, Unit>> call(String id, TaskEntity data) async {
    final res = await repository.updateFromId(id, data);
    if (res.isLeft()) return res.map((_) => unit);
    return policy.afterUpdate(id, data);
  }
}
