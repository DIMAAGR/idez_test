import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/modules/shared/domain/usecases/get_all_tasks_use_case.dart';
import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';
import 'package:idez_test/src/core/errors/failure.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late GetAllTasksUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    usecase = GetAllTasksUseCaseImpl(repo);
  });

  test('retorna lista de TaskEntity no sucesso', () async {
    final tasks = [
      TaskEntity(id: '1', title: 'A', done: false, createdAt: DateTime(2024)),
      TaskEntity(id: '2', title: 'B', done: true, createdAt: DateTime(2024, 2)),
    ];

    when(repo.getAllTasks()).thenAnswer((_) async => Right(tasks));

    final result = await usecase();

    expect(result.isRight(), true);
    result.fold((_) => fail('esperava sucesso'), (r) => expect(r, tasks));
  });

  test('retorna Failure no erro', () async {
    when(repo.getAllTasks()).thenAnswer((_) async => Left(StorageFailure('x')));

    final result = await usecase();

    expect(result.isLeft(), true);
  });
}
