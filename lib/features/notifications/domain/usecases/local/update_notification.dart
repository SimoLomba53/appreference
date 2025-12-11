import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:growingapp/features/notifications/domain/repository/local/notifications_repository.dart';

class UpdateNotificationUseCase extends UseCase<void, NotificationEntity> {
  final LocalNotificationRepository _LocalNotificationRepository;

  UpdateNotificationUseCase(this._LocalNotificationRepository);

  @override
  Future<void> call({NotificationEntity? params}) {
    return _LocalNotificationRepository.updateNotification(params!);
  }
}
