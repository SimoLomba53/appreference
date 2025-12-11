import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';

abstract class NotificationState extends Equatable {
  final List<NotificationEntity>? notifications;
  final DioException? error;

  const NotificationState({this.notifications, this.error});

  @override
  List<Object?> get props => [notifications, error];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationScheduled extends NotificationState {}

class NotificationCancelled extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);
}
