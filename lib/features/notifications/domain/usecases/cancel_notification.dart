import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:growingapp/features/notifications/domain/repository/notifications_repository.dart';

class CancelNotificationUseCase implements UseCase<void, NotificationEntity?> {
  final NotificationRepository repository;

  CancelNotificationUseCase(this.repository);

  @override
  Future<void> call({NotificationEntity? params}) async {
    await repository.cancelNotification(params!);
  }
}
