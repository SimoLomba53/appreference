import 'package:growingapp/features/terrarium/data/data_sources/local/app_database.dart';
import 'package:growingapp/features/notifications/data/models/notification.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:growingapp/features/notifications/domain/repository/local/notifications_repository.dart';

class LocalNotificationRepositoryImpl implements LocalNotificationRepository {
  final AppDatabase _appDatabase;

  LocalNotificationRepositoryImpl(this._appDatabase);

  @override
  Future<List<NotificationEntity>> getSavedNotifications() async {
    return _appDatabase.notificationDAO.getNotifications();
  }

  @override
  Future<void> removeNotification(NotificationEntity notification) {
    return _appDatabase.notificationDAO
        .deleteNotification(NotificationModel.fromEntity(notification));
  }

  @override
  Future<void> saveNotification(NotificationEntity notification) {
    return _appDatabase.notificationDAO
        .insertNotification(NotificationModel.fromEntity(notification));
  }

  @override
  Future<void> updateNotification(NotificationEntity notification) {
    return _appDatabase.notificationDAO
        .updateNotification(NotificationModel.fromEntity(notification));
  }
}
