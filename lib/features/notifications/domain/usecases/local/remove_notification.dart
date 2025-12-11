import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:growingapp/features/notifications/domain/repository/local/notifications_repository.dart';

class RemoveNotificationUseCase extends UseCase<void, NotificationEntity> {
  final LocalNotificationRepository _LocalNotificationRepository;

  RemoveNotificationUseCase(this._LocalNotificationRepository);

  @override
  Future<void> call({NotificationEntity? params}) {
    return _LocalNotificationRepository.removeNotification(params!);
  }
}
