import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../shared/domain/repository/shared_repository.dart';
import '../../../shared/domain/gateways/notification_gateway.dart';
import '../../../shared/domain/services/reminder_policy.dart';

abstract class ToggleAllNotificationsUseCase {
  Future<Either<Failure, Unit>> call(bool enable);
}

class ToggleAllNotificationsUseCaseImpl implements ToggleAllNotificationsUseCase {
  final SharedRepository _repo;
  final NotificationGateway _gateway;
  final ReminderPolicy _policy;
  ToggleAllNotificationsUseCaseImpl(this._repo, this._gateway, this._policy);

  @override
  Future<Either<Failure, Unit>> call(bool enable) async {
    try {
      if (!enable) {
        await _gateway.cancelAll();
        return right(unit);
      }

      final tasksRes = await _repo.getAllTasks();
      return await tasksRes.fold((f) => left(f), (tasks) async {
        final now = DateTime.now();
        for (final t in tasks) {
          final due = t.dueDate;
          if (due != null && due.isAfter(now)) {
            final r = await _policy.afterCreate(t);
            if (r.isLeft()) return r;
          }
        }
        return right(unit);
      });
    } catch (e, s) {
      return left(NotificationFailure('Falha ao alternar notificações', cause: e, stackTrace: s));
    }
  }
}
