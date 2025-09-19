import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../gateways/notification_gateway.dart';

abstract class CancelTaskRemindersUseCase {
  Future<Either<Failure, void>> call(String taskId);
}

class CancelTaskRemindersUseCaseImpl implements CancelTaskRemindersUseCase {
  final NotificationGateway _gateway;
  CancelTaskRemindersUseCaseImpl(this._gateway);

  int _idMain(String taskId) => taskId.hashCode;
  int _idMinus30(String taskId) => '${taskId}_-30'.hashCode;
  int _idMinus5(String taskId) => '${taskId}_-5'.hashCode;

  @override
  Future<Either<Failure, void>> call(String taskId) async {
    try {
      await _gateway.cancel(_idMain(taskId));
      await _gateway.cancel(_idMinus30(taskId));
      await _gateway.cancel(_idMinus5(taskId));
      return const Right(null);
    } catch (e, s) {
      return Left(NotificationFailure('Falha ao cancelar lembretes', cause: e, stackTrace: s));
    }
  }
}
