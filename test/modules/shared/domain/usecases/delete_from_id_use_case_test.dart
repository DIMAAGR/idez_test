import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/delete_from_id_use_case.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late MockReminderPolicy policy;
  late DeleteFromIdUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    policy = MockReminderPolicy();
    usecase = DeleteFromIdUseCaseImpl(repo, policy);
  });

  test('sucesso: delega pro repo e chama policy.afterDelete', () async {
    const id = 'abc';

    when(repo.deleteFromId(id)).thenAnswer((_) async => const Right(null));
    when(policy.afterDelete(id)).thenAnswer((_) async => const Right(unit));

    final res = await usecase(id);

    expect(res.isRight(), true);

    verify(repo.deleteFromId(id)).called(1);
    verify(policy.afterDelete(id)).called(1);
    verifyNoMoreInteractions(repo);
    verifyNoMoreInteractions(policy);
  });

  test('falha: se repo falhar, retorna Left e não chama policy', () async {
    const id = 'err-1';
    final failure = StorageFailure('boom');

    when(repo.deleteFromId(id)).thenAnswer((_) async => Left(failure));

    final res = await usecase(id);

    expect(res.isLeft(), true);
    res.fold((l) => expect(l, failure), (_) => fail('não deveria'));

    verify(repo.deleteFromId(id)).called(1);
    verifyZeroInteractions(policy);
  });

  test('falha: se policy.afterDelete falhar, retorna Left', () async {
    const id = 'err-2';
    final failure = NotificationFailure('fail');

    when(repo.deleteFromId(id)).thenAnswer((_) async => const Right(null));
    when(policy.afterDelete(id)).thenAnswer((_) async => Left(failure));

    final res = await usecase(id);

    expect(res.isLeft(), true);
    res.fold((l) => expect(l, failure), (_) => fail('não deveria'));

    verify(repo.deleteFromId(id)).called(1);
    verify(policy.afterDelete(id)).called(1);
    verifyNoMoreInteractions(repo);
    verifyNoMoreInteractions(policy);
  });
}
