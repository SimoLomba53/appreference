import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:growingapp/features/notifications/domain/repository/notifications_repository.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationRepositoryImpl(this.flutterLocalNotificationsPlugin);

  Future<void> showNotification(NotificationEntity notification) async {
    await flutterLocalNotificationsPlugin.show(
      Random(45).nextInt(1000000000000),
      notification.title,
      notification.body,
      const NotificationDetails(),
    );
  }

  @override
  Future<void> scheduleNotification(NotificationEntity notification) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notification.groupId ?? 0,
      notification.title,
      notification.body,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          groupKey: 'com.growingartterrariums.flutter_push_notifications',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          ticker: 'ticker',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Future<void> cancelNotification(NotificationEntity notification) async {
    await flutterLocalNotificationsPlugin.cancel(notification.groupId ?? -1);
  }
}
