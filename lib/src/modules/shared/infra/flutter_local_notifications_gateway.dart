import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import '../domain/gateways/notification_gateway.dart';

class FlutterLocalNotificationsGateway implements NotificationGateway {
  final FlutterLocalNotificationsPlugin _plugin;
  FlutterLocalNotificationsGateway(this._plugin);

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required TZDateTime when,
    Map<String, String>? payload,
  }) async {
    const android = AndroidNotificationDetails(
      'tasks_channel',
      'Tasks',
      channelDescription: 'Task reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      when,
      details,
      payload: payload?.toString(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  @override
  Future<void> cancel(int id) => _plugin.cancel(id);

  @override
  Future<void> cancelAll() => _plugin.cancelAll();
}
