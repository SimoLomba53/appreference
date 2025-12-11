import 'package:floor/floor.dart';
import 'package:growingapp/features/notifications/data/models/notification.dart';

@dao
abstract class NotificationDao {
  
  @Insert()
  Future<void> insertNotification(NotificationModel notification);

  @delete
  Future<void> deleteNotification(NotificationModel notification);

  @Query('SELECT * FROM notification')
  Future<List<NotificationModel>> getNotifications();
  
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNotification(NotificationModel notification);
}
