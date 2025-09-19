import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_notification_enabled_use_case.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late GetNotificationEnabledUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    usecase = GetNotificationEnabledUseCaseImpl(repo);
  });

  test('sucesso: retorna true quando repo habilitado', () async {
    when(repo.getNotificationEnabled()).thenAnswer((_) async => const Right(true));

    final result = await usecase();

    expect(result.isRight(), true);
    result.fold((_) => fail('não deveria falhar'), (enabled) {
      expect(enabled, true);
    });

    verify(repo.getNotificationEnabled()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('sucesso: retorna false quando repo desabilitado', () async {
    when(repo.getNotificationEnabled()).thenAnswer((_) async => const Right(false));

    final result = await usecase();

    expect(result.isRight(), true);
    result.fold((_) => fail('não deveria falhar'), (enabled) {
      expect(enabled, false);
    });

    verify(repo.getNotificationEnabled()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('falha: retorna Left(StorageFailure)', () async {
    final failure = StorageFailure('boom');
    when(repo.getNotificationEnabled()).thenAnswer((_) async => Left(failure));

    final result = await usecase();

    expect(result.isLeft(), true);
    result.fold((l) => expect(l, failure), (_) => fail('não deveria ter sucesso'));

    verify(repo.getNotificationEnabled()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
