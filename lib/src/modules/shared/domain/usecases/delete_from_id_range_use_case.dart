import 'package:dartz/dartz.dart';
import 'package:idez_test/src/core/errors/failure.dart';

import '../repository/shared_repository.dart';
import '../services/reminder_policy.dart';

abstract class DeleteFromIdRangeUseCase {
  Future<Either<Failure, void>> call(Iterable<String> ids);
}

class DeleteFromIdRangeUseCaseImpl implements DeleteFromIdRangeUseCase {
  final SharedRepository repository;
  final ReminderPolicy policy;

  DeleteFromIdRangeUseCaseImpl(this.repository, this.policy);

  @override
  Future<Either<Failure, Unit>> call(Iterable<String> ids) async {
    final res = await repository.deleteFromIdRange(ids);
    if (res.isLeft()) return res.map((_) => unit);
    return policy.afterDeleteMany(ids);
  }
}
