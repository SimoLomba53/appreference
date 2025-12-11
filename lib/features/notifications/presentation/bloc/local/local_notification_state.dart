import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';

abstract class LocalNotificationsState extends Equatable {
  final List<NotificationEntity>? notifications;
  final DioException? error;

  const LocalNotificationsState({this.notifications, this.error});

  @override
  List<Object?> get props => [notifications, error];
}

class LocalNotificationsLoading extends LocalNotificationsState {
  const LocalNotificationsLoading();
}

class LocalNotificationsDone extends LocalNotificationsState {
  const LocalNotificationsDone(List<NotificationEntity> notifications)
      : super(notifications: notifications);
}
