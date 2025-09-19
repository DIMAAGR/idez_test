import 'package:timezone/timezone.dart';

abstract class NotificationGateway {
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required TZDateTime when,
    Map<String, String>? payload,
  });
  Future<void> cancel(int id);
  Future<void> cancelAll();
}
