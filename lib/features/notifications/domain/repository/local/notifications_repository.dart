import 'package:growingapp/features/notifications/domain/entities/notification.dart';

abstract class LocalNotificationRepository {
  //Database methods
  Future<List<NotificationEntity>> getSavedNotifications();

  Future<void> saveNotification(NotificationEntity notification);

  Future<void> removeNotification(NotificationEntity notification);

  Future<void> updateNotification(NotificationEntity notification);
}
