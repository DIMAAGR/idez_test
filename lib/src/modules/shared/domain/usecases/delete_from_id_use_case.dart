import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/shared_repository.dart';
import '../services/reminder_policy.dart';

abstract class DeleteFromIdUseCase {
  Future<Either<Failure, void>> call(String id);
}

class DeleteFromIdUseCaseImpl implements DeleteFromIdUseCase {
  final SharedRepository repository;
  final ReminderPolicy policy;

  DeleteFromIdUseCaseImpl(this.repository, this.policy);

  @override
  Future<Either<Failure, Unit>> call(String id) async {
    final res = await repository.deleteFromId(id);
    if (res.isLeft()) return res.map((_) => unit);
    return policy.afterDelete(id);
  }
}
