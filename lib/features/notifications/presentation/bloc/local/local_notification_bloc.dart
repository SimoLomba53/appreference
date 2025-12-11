import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/features/notifications/domain/usecases/local/get_saved_notifications.dart';
import 'package:growingapp/features/notifications/domain/usecases/local/remove_notification.dart';
import 'package:growingapp/features/notifications/domain/usecases/local/save_notification.dart';
import 'package:growingapp/features/notifications/domain/usecases/local/update_notification.dart';
import 'package:growingapp/features/notifications/presentation/bloc/local/local_notification_event.dart';
import 'package:growingapp/features/notifications/presentation/bloc/local/local_notification_state.dart';

class LocalNotificationsBloc
    extends Bloc<LocalNotificationsEvent, LocalNotificationsState> {
  final GetSavedNotificationsUseCase _getSavedNotificationsUseCase;
  final SaveNotificationUseCase _saveNotificationUseCase;
  final RemoveNotificationUseCase _removeNotificationUseCase;
  final UpdateNotificationUseCase _updateNotificationUseCase;

  LocalNotificationsBloc(
      this._getSavedNotificationsUseCase,
      this._saveNotificationUseCase,
      this._removeNotificationUseCase,
      this._updateNotificationUseCase)
      : super(const LocalNotificationsLoading()) {
    on<GetSavedNotifications>(onGetSavedNotifications);
    on<SaveNotification>(onSaveNotification);
    on<RemoveNotification>(onRemoveNotification);
    on<UpdateNotification>(onUpdateNotification);
  }

  Future<void> onGetSavedNotifications(
      GetSavedNotifications getSavedNotifications,
      Emitter<LocalNotificationsState> emit) async {
    final notifications = await _getSavedNotificationsUseCase();
    emit(LocalNotificationsDone(notifications));
  }

  Future<void> onRemoveNotification(RemoveNotification removeNotification,
      Emitter<LocalNotificationsState> emit) async {
    await _removeNotificationUseCase(params: removeNotification.notification);
    final notifications = await _getSavedNotificationsUseCase();
    emit(LocalNotificationsDone(notifications));
  }

  Future<void> onSaveNotification(SaveNotification saveNotification,
      Emitter<LocalNotificationsState> emit) async {
    await _saveNotificationUseCase(params: saveNotification.notification);
    final notifications = await _getSavedNotificationsUseCase();
    emit(LocalNotificationsDone(notifications));
  }

  Future<void> onUpdateNotification(UpdateNotification updateNotification,
      Emitter<LocalNotificationsState> emit) async {
    await _updateNotificationUseCase(params: updateNotification.notification);
    final notifications = await _getSavedNotificationsUseCase();
    emit(LocalNotificationsDone(notifications));
  }
}
