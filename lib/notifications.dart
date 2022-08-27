import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidSettings =
      const AndroidInitializationSettings('logo');

  void initNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidSettings,
    );

    await _notifications.initialize(initializationSettings);
  }

  void sendNotification(String? title, String? body) async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails('pilltake', 'pt notify',
          importance: Importance.max, priority: Priority.high),
      iOS: IOSNotificationDetails(),
    );

    _notifications.show(0, title, body, details);
  }
}
