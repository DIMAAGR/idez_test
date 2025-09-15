import 'package:dartz/dartz.dart';
import 'package:idez_test/src/modules/shared/data/models/task_model.dart';

import '../../../../core/errors/failure.dart';
import '../repository/shared_repository.dart';

abstract class UpdateTaskFromIdUseCase {
  Future<Either<Failure, void>> call(String id, TaskModel data);
}

class UpdateTaskFromIdUseCaseImpl implements UpdateTaskFromIdUseCase {
  final SharedRepository repository;

  UpdateTaskFromIdUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(String id, TaskModel data) {
    return repository.updateFromId(id, data);
  }
}
