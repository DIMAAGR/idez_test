import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/cancel_task_reminders_use_case.dart';
import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockNotificationGateway gateway;
  late CancelTaskRemindersUseCase usecase;

  int idMain(String taskId) => taskId.hashCode;
  int idMinus30(String taskId) => '${taskId}_-30'.hashCode;
  int idMinus5(String taskId) => '${taskId}_-5'.hashCode;

  setUp(() {
    gateway = MockNotificationGateway();
    usecase = CancelTaskRemindersUseCaseImpl(gateway);
  });

  group('CancelTaskRemindersUseCase', () {
    test('sucesso: cancela main, -30 e -5 (nessa ordem)', () async {
      const taskId = 'task-123';
      final ids = [idMain(taskId), idMinus30(taskId), idMinus5(taskId)];

      when(gateway.cancel(ids[0])).thenAnswer((_) async {});
      when(gateway.cancel(ids[1])).thenAnswer((_) async {});
      when(gateway.cancel(ids[2])).thenAnswer((_) async {});

      final res = await usecase(taskId);

      expect(res.isRight(), true);

      verifyInOrder([gateway.cancel(ids[0]), gateway.cancel(ids[1]), gateway.cancel(ids[2])]);
      verifyNoMoreInteractions(gateway);
    });

    test('falha: se a 1ª chamada lançar, retorna Left e não chama as próximas', () async {
      const taskId = 'task-err-1';
      final main = idMain(taskId);

      when(gateway.cancel(main)).thenThrow(Exception('io'));

      final res = await usecase(taskId);

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<NotificationFailure>()), (_) => fail('não deveria'));

      verify(gateway.cancel(main)).called(1);
      verifyNever(gateway.cancel(idMinus30(taskId)));
      verifyNever(gateway.cancel(idMinus5(taskId)));
      verifyNoMoreInteractions(gateway);
    });

    test('falha: se a 2ª chamada lançar, retorna Left e não chama a 3ª', () async {
      const taskId = 'task-err-2';
      final main = idMain(taskId);
      final minus30 = idMinus30(taskId);

      when(gateway.cancel(main)).thenAnswer((_) async {});
      when(gateway.cancel(minus30)).thenThrow(Exception('io-2'));

      final res = await usecase(taskId);

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<NotificationFailure>()), (_) => fail('não deveria'));

      verify(gateway.cancel(main)).called(1);
      verify(gateway.cancel(minus30)).called(1);
      verifyNever(gateway.cancel(idMinus5(taskId)));
      verifyNoMoreInteractions(gateway);
    });
  });
}
