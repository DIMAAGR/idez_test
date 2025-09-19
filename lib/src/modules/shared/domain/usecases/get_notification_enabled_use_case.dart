import 'package:dartz/dartz.dart';
import 'package:idez_test/src/modules/shared/domain/repository/shared_repository.dart';

import '../../../../core/errors/failure.dart';

abstract class GetNotificationEnabledUseCase {
  Future<Either<Failure, bool>> call();
}

class GetNotificationEnabledUseCaseImpl implements GetNotificationEnabledUseCase {
  final SharedRepository _repository;

  GetNotificationEnabledUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call() {
    return _repository.getNotificationEnabled();
  }
}
