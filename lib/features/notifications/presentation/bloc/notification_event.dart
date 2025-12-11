import 'package:equatable/equatable.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';

abstract class NotificationEvent extends Equatable {
  final NotificationEntity? notification;

  const NotificationEvent({this.notification});

  @override
  List<Object> get props => [notification!];
}

class ScheduleNotification extends NotificationEvent {
  const ScheduleNotification(NotificationEntity? notification) : super(notification: notification);
}

class CancelNotification extends NotificationEvent {
  const CancelNotification(NotificationEntity? notification)
      : super(notification: notification);
}
