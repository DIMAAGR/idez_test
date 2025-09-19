import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/delete_from_id_range_use_case.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late MockReminderPolicy policy;
  late DeleteFromIdRangeUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    policy = MockReminderPolicy();
    usecase = DeleteFromIdRangeUseCaseImpl(repo, policy);
  });

  test('sucesso: delega ao repo e chama policy.afterDeleteMany', () async {
    when(repo.deleteFromIdRange(any)).thenAnswer((_) async => const Right(null));
    when(policy.afterDeleteMany(any)).thenAnswer((_) async => const Right(unit));

    final result = await usecase(['1', '2']);

    expect(result.isRight(), true);
    verify(repo.deleteFromIdRange(any)).called(1);
    verify(policy.afterDeleteMany(any)).called(1);
    verifyNoMoreInteractions(repo);
    verifyNoMoreInteractions(policy);
  });

  test('falha no repo: retorna Left e NÃO chama policy', () async {
    final failure = StorageFailure('boom');

    when(repo.deleteFromIdRange(any)).thenAnswer((_) async => Left(failure));

    final result = await usecase(['x']);

    expect(result.isLeft(), true);
    result.fold((l) => expect(l, failure), (_) => fail('não deveria'));
    verify(repo.deleteFromIdRange(any)).called(1);
    verifyZeroInteractions(policy);
  });

  test('falha na policy: retorna Left da policy', () async {
    final failure = NotificationFailure('policy fail');

    when(repo.deleteFromIdRange(any)).thenAnswer((_) async => const Right(null));
    when(policy.afterDeleteMany(any)).thenAnswer((_) async => Left(failure));

    final result = await usecase(['z']);

    expect(result.isLeft(), true);
    result.fold((l) => expect(l, failure), (_) => fail('não deveria'));

    verify(repo.deleteFromIdRange(any)).called(1);
    verify(policy.afterDeleteMany(any)).called(1);
    verifyNoMoreInteractions(repo);
    verifyNoMoreInteractions(policy);
  });
}
