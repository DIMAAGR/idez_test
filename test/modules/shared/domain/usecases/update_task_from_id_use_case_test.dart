import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/update_task_from_id_use_case.dart';
import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late MockReminderPolicy policy;
  late UpdateTaskFromIdUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    policy = MockReminderPolicy();
    usecase = UpdateTaskFromIdUseCaseImpl(repo, policy);
  });

  test('sucesso: delega ao repo e chama policy.afterUpdate', () async {
    const id = 'abc';
    final data = TaskEntity(
      id: id,
      title: 'Edit',
      done: false,
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
    );

    when(repo.updateFromId(id, data)).thenAnswer((_) async => const Right(null));
    when(policy.afterUpdate(id, data)).thenAnswer((_) async => const Right(unit));

    final res = await usecase(id, data);

    expect(res.isRight(), true);
    verify(repo.updateFromId(id, data)).called(1);
    verify(policy.afterUpdate(id, data)).called(1);
    verifyNoMoreInteractions(repo);
    verifyNoMoreInteractions(policy);
  });

  test('falha no repo: retorna Left e NÃO chama policy', () async {
    const id = 'err-1';
    final data = TaskEntity(
      id: id,
      title: 'X',
      done: false,
      dueDate: null,
      createdAt: DateTime.now(),
    );
    final failure = StorageFailure('boom');

    when(repo.updateFromId(id, data)).thenAnswer((_) async => Left(failure));

    final res = await usecase(id, data);

    expect(res.isLeft(), true);
    res.fold((l) => expect(l, failure), (_) => fail('não deveria'));
    verify(repo.updateFromId(id, data)).called(1);
    verifyZeroInteractions(policy);
  });

  test('falha na policy: retorna Left da policy', () async {
    const id = 'err-2';
    final data = TaskEntity(
      id: id,
      title: 'Y',
      done: true,
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
    );
    final failure = NotificationFailure('policy failed');

    when(repo.updateFromId(id, data)).thenAnswer((_) async => const Right(null));
    when(policy.afterUpdate(id, data)).thenAnswer((_) async => Left(failure));

    final res = await usecase(id, data);

    expect(res.isLeft(), true);
    res.fold((l) => expect(l, failure), (_) => fail('não deveria'));
    verify(repo.updateFromId(id, data)).called(1);
    verify(policy.afterUpdate(id, data)).called(1);
    verifyNoMoreInteractions(repo);
    verifyNoMoreInteractions(policy);
  });
}
