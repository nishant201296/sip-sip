import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

abstract class INotificationService {
  Future<void> initNotification(InitializationSettings settings);
  Future<void> notifySchdeuled(int id, String? title, String? body,
      TZDateTime scheduledDate, NotificationDetails notificationDetails);
}

class NotificationService implements INotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initNotification(InitializationSettings settings) async {
    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  @override
  Future<void> notifySchdeuled(int id, String? title, String? body,
      TZDateTime scheduledDate, NotificationDetails notificationDetails) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
