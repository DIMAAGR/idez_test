import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/schedule_task_reminders_use_case.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockNotificationGateway gateway;
  late ScheduleTaskRemindersUseCase usecase;

  int idMain(String taskId) => taskId.hashCode;
  int idMinus30(String taskId) => '${taskId}_-30'.hashCode;
  int idMinus5(String taskId) => '${taskId}_-5'.hashCode;

  setUp(() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Bahia'));
    gateway = MockNotificationGateway();
    usecase = ScheduleTaskRemindersUseCaseImpl(gateway);
  });

  group('ScheduleTaskRemindersUseCase', () {
    test('dueDate null: retorna Right e não agenda nada', () async {
      final task = TaskEntity(
        id: 't0',
        title: 'X',
        done: false,
        dueDate: null,
        createdAt: DateTime.now(),
      );

      final res = await usecase(task);

      expect(res.isRight(), true);
      verifyZeroInteractions(gateway);
    });

    test('futuro distante: agenda -30, -5 e principal nessa ordem', () async {
      const id = 't1';
      final due = DateTime.now().add(const Duration(hours: 2));
      final task = TaskEntity(
        id: id,
        title: 'Reunião',
        done: false,
        dueDate: due,
        createdAt: DateTime.now(),
      );

      when(
        gateway.schedule(
          id: anyNamed('id'),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      ).thenAnswer((_) async {});

      final res = await usecase(task);
      expect(res.isRight(), true);

      verifyInOrder([
        gateway.schedule(
          id: idMinus30(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
        gateway.schedule(
          id: idMinus5(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
        gateway.schedule(
          id: idMain(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      ]);

      verifyNoMoreInteractions(gateway);
    });

    test('futuro próximo (10m): agenda -5 e principal; NÃO agenda -30', () async {
      const id = 't2';
      final due = DateTime.now().add(const Duration(minutes: 10));
      final task = TaskEntity(
        id: id,
        title: 'Standup',
        done: false,
        dueDate: due,
        createdAt: DateTime.now(),
      );

      when(
        gateway.schedule(
          id: anyNamed('id'),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      ).thenAnswer((_) async {});

      final res = await usecase(task);
      expect(res.isRight(), true);

      verifyNever(
        gateway.schedule(
          id: idMinus30(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      );

      verifyInOrder([
        gateway.schedule(
          id: idMinus5(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
        gateway.schedule(
          id: idMain(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      ]);

      verifyNoMoreInteractions(gateway);
    });

    test('erro ao agendar: retorna Left(NotificationFailure)', () async {
      const id = 't3';
      final due = DateTime.now().add(const Duration(hours: 1));
      final task = TaskEntity(
        id: id,
        title: 'Call',
        done: false,
        dueDate: due,
        createdAt: DateTime.now(),
      );

      when(
        gateway.schedule(
          id: idMinus30(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      ).thenThrow(Exception('io'));

      final res = await usecase(task);

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<NotificationFailure>()), (_) => fail('não deveria'));

      verify(
        gateway.schedule(
          id: idMinus30(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      ).called(1);

      verifyNever(
        gateway.schedule(
          id: idMinus5(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      );
      verifyNever(
        gateway.schedule(
          id: idMain(id),
          title: anyNamed('title'),
          body: anyNamed('body'),
          when: anyNamed('when'),
          payload: anyNamed('payload'),
        ),
      );

      verifyNoMoreInteractions(gateway);
    });
  });
}
