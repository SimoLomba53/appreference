import 'dart:convert';

import 'package:growingapp/features/notifications/data/models/notification.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';

class Task {}

class TaskNotification extends Task {
  String id;
  String terrariumId;
  int lastNotificationTimeInSeconds;
  int maxTimeBetweenNotificationsInSeconds;
  NotificationEntity notification;

  TaskNotification({
    required this.id,
    required this.terrariumId,
    required this.lastNotificationTimeInSeconds,
    required this.maxTimeBetweenNotificationsInSeconds,
    required this.notification,
  });

  factory TaskNotification.fromJson(Map<String, dynamic> map) {
    return TaskNotification(
      id: map['id'] ?? "",
      terrariumId: map['terrariumId'] ?? "",
      lastNotificationTimeInSeconds: map['lastNotificationTimeInSeconds'] ?? 0,
      maxTimeBetweenNotificationsInSeconds:
          map['maxTimeBetweenNotificationsInSeconds'] ?? 0,
      notification: NotificationModel.fromJson(map['notification']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'terrariumId': terrariumId,
      'lastNotificationTimeInSeconds': lastNotificationTimeInSeconds,
      'maxTimeBetweenNotificationsInSeconds': maxTimeBetweenNotificationsInSeconds,
      'notification': notification.toJson(),
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
