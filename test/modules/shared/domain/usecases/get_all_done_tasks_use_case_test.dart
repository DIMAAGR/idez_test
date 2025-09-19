import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_all_done_tasks_use_case.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late GetAllDoneTasksUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    usecase = GetAllDoneTasksUseCaseImpl(repo);
  });

  test('sucesso: retorna lista de tarefas concluídas do repo', () async {
    final expected = [
      TaskEntity(id: '1', title: 'Task 1', done: true, createdAt: DateTime.now()),
      TaskEntity(id: '2', title: 'Task 2', done: true, createdAt: DateTime.now()),
    ];

    when(repo.getAllDoneTasks()).thenAnswer((_) async => Right(expected));

    final result = await usecase();

    expect(result.isRight(), true);
    result.fold((_) => fail('não deveria falhar'), (list) {
      expect(list, expected);
      expect(list.every((t) => t.done), true);
    });

    verify(repo.getAllDoneTasks()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('falha: retorna Left(StorageFailure)', () async {
    final failure = StorageFailure('boom');

    when(repo.getAllDoneTasks()).thenAnswer((_) async => Left(failure));

    final result = await usecase();

    expect(result.isLeft(), true);
    result.fold((l) => expect(l, failure), (_) => fail('não deveria ter sucesso'));

    verify(repo.getAllDoneTasks()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
