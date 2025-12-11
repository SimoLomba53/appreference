import 'package:equatable/equatable.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';

abstract class LocalNotificationsEvent extends Equatable {
  final NotificationEntity? notification;

  const LocalNotificationsEvent({this.notification});

  @override
  List<Object?> get props => [notification];
}

class GetSavedNotifications extends LocalNotificationsEvent {
  const GetSavedNotifications();
}

class RemoveNotification extends LocalNotificationsEvent {
  const RemoveNotification(NotificationEntity notification) : super(notification: notification);
}

class SaveNotification extends LocalNotificationsEvent {
  const SaveNotification(NotificationEntity notification)
      : super(notification: notification);
}

class UpdateNotification extends LocalNotificationsEvent {
  const UpdateNotification(NotificationEntity notification) : super(notification: notification);
}
