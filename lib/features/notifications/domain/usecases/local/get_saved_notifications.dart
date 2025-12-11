import 'package:growingapp/core/usecases/usecase.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:growingapp/features/notifications/domain/repository/local/notifications_repository.dart';

class GetSavedNotificationsUseCase
    extends UseCase<List<NotificationEntity>, void> {
  final LocalNotificationRepository _LocalNotificationRepository;

  GetSavedNotificationsUseCase(this._LocalNotificationRepository);

  @override
  Future<List<NotificationEntity>> call({void params}) {
    return _LocalNotificationRepository.getSavedNotifications();
  }
}
