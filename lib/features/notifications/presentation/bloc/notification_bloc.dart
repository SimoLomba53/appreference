import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/features/notifications/domain/usecases/cancel_notification.dart';
import 'package:growingapp/features/notifications/domain/usecases/schedule_notification.dart';
import 'package:growingapp/features/notifications/presentation/bloc/notification_event.dart';
import 'package:growingapp/features/notifications/presentation/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ScheduleNotificationUseCase scheduleNotificationUseCase;
  final CancelNotificationUseCase cancelNotificationUseCase;

  NotificationBloc(
    this.scheduleNotificationUseCase,
    this.cancelNotificationUseCase,
  ) : super(NotificationInitial()) {
    on<ScheduleNotification>(_onScheduleNotification);
    on<CancelNotification>(_onCancelNotification);
  }

  Future<void> _onScheduleNotification(
      ScheduleNotification event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      await scheduleNotificationUseCase(params: event.notification);
      emit(NotificationScheduled());
    } catch (error) {
      emit(const NotificationError('Failed to schedule notification'));
    }
  }

  Future<void> _onCancelNotification(
      CancelNotification event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      await cancelNotificationUseCase(params: event.notification);
      emit(NotificationCancelled());
    } catch (error) {
      emit(const NotificationError('Failed to cancel notification'));
    }
  }
}
