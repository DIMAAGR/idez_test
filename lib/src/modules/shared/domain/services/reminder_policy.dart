import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/task_entity.dart';
import '../usecases/cancel_task_reminders_use_case.dart';
import '../usecases/schedule_task_reminders_use_case.dart';
import '../usecases/get_notification_enabled_use_case.dart';

class ReminderPolicy {
  final CancelTaskRemindersUseCase cancel;
  final ScheduleTaskRemindersUseCase schedule;
  final GetNotificationEnabledUseCase isEnabled;

  const ReminderPolicy(this.cancel, this.schedule, this.isEnabled);

  Future<Either<Failure, Unit>> afterCreate(TaskEntity t) async {
    final enabled = await isEnabled();

    if (enabled.getOrElse(() => false) && t.dueDate != null) {
      final r = await schedule(t);
      return r.map((_) => unit);
    }
    return right(unit);
  }

  Future<Either<Failure, Unit>> afterUpdate(String id, TaskEntity t) async {
    final c = await cancel(id);
    if (c.isLeft()) return c.map((_) => unit);

    final enabled = await isEnabled();
    if (enabled.getOrElse(() => false) && t.dueDate != null) {
      final r = await schedule(t);
      return r.map((_) => unit);
    }
    return right(unit);
  }

  Future<Either<Failure, Unit>> afterDelete(String id) async {
    final r = await cancel(id);
    return r.map((_) => unit);
  }

  Future<Either<Failure, Unit>> afterDeleteMany(Iterable<String> ids) async {
    for (final id in ids) {
      final r = await cancel(id);
      if (r.isLeft()) return r.map((_) => unit);
    }
    return right(unit);
  }
}
