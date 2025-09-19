import 'package:dartz/dartz.dart';
import 'package:idez_test/src/core/extensions/date_time_extension.dart';
import '../../../../core/errors/failure.dart';
import '../entities/task_entity.dart';
import '../gateways/notification_gateway.dart';

abstract class ScheduleTaskRemindersUseCase {
  Future<Either<Failure, void>> call(TaskEntity task);
}

class ScheduleTaskRemindersUseCaseImpl implements ScheduleTaskRemindersUseCase {
  final NotificationGateway _gateway;
  ScheduleTaskRemindersUseCaseImpl(this._gateway);

  int _idMain(String taskId) => taskId.hashCode;
  int _idMinus30(String taskId) => '${taskId}_-30'.hashCode;
  int _idMinus5(String taskId) => '${taskId}_-5'.hashCode;

  @override
  Future<Either<Failure, void>> call(TaskEntity task) async {
    try {
      if (task.dueDate == null) return const Right(null);

      final now = DateTime.now();
      final due = task.dueDate!;
      final t30 = due.subtract(const Duration(minutes: 30)).toTZDateTime();
      final t5 = due.subtract(const Duration(minutes: 5)).toTZDateTime();

      if (t30.isAfter(now)) {
        await _gateway.schedule(
          id: _idMinus30(task.id),
          title: 'Em 30 min: ${task.title}',
          body: 'Seu lembrete começa em 30 minutos.',
          when: t30,
          payload: {'taskId': task.id},
        );
      }
      if (t5.isAfter(now)) {
        await _gateway.schedule(
          id: _idMinus5(task.id),
          title: 'Em 5 min: ${task.title}',
          body: 'Quase lá! 5 minutos restantes.',
          when: t5,
          payload: {'taskId': task.id},
        );
      }
      if (due.isAfter(now)) {
        await _gateway.schedule(
          id: _idMain(task.id),
          title: task.title,
          body: 'Chegou a hora da sua tarefa.',
          when: due.toTZDateTime(),
          payload: {'taskId': task.id},
        );
      }

      return const Right(null);
    } catch (e, s) {
      return Left(NotificationFailure('Falha ao agendar lembretes', cause: e, stackTrace: s));
    }
  }
}
