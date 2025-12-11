import 'package:growingapp/features/notifications/domain/entities/notification.dart';

abstract class NotificationRepository {
  Future<void> scheduleNotification(NotificationEntity notification);
  
  Future<void> cancelNotification(NotificationEntity notification);
}
