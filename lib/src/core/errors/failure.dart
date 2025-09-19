// O QUE É UMA SEALED CLASS?
//
// Uma sealed class é uma classe que pode ser estendida ou implementada apenas dentro do mesmo
// arquivo onde foi declarada. Isso permite que você controle todas as subclasses possíveis de uma
// classe, garantindo que todas as variações sejam conhecidas e gerenciadas em um único local.
// Isso é útil para representar hierarquias de classes fechadas, onde você deseja limitar as
// subclasses a um conjunto específico, facilitando a manutenção e a compreensão do código.
sealed class Failure {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;
  const Failure(this.message, {this.cause, this.stackTrace});
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.m = 'Not found']);
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.m);
}

final class StorageFailure extends Failure {
  const StorageFailure(super.m, {super.cause, super.stackTrace});
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.m, {super.cause, super.stackTrace});
}

final class NotificationFailure extends Failure {
  const NotificationFailure(super.m, {super.cause, super.stackTrace});
}
