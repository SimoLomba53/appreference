import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:growingapp/features/notifications/domain/repository/notifications_repository.dart';

class ScheduleNotificationUseCase
    implements UseCase<void, NotificationEntity?> {
  final NotificationRepository repository;

  ScheduleNotificationUseCase(this.repository);

  @override
  Future<void> call({NotificationEntity? params}) async {
    await repository.scheduleNotification(params!);
  }
}
