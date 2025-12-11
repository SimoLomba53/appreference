
import 'package:floor/floor.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';

@Entity(tableName: 'notification', primaryKeys: ['id'])

//ignore: must_be_immutable
class NotificationModel extends NotificationEntity {
  NotificationModel({
    super.id,
    super.groupId,
    super.title,
    super.body,
    super.payload,
    super.scheduledDate,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? "",
      groupId: map['groupId'] ?? 0,
      title: map['title'] ?? "",
      body: map['body'] ?? "",
      payload: map['payload'] ?? "",
      scheduledDate: map['scheduledDate'] != null
          ? DateTime.parse(map['scheduledDate'])
          : DateTime.now(),
    );
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      groupId: entity.groupId,
      title: entity.title,
      body: entity.body,
      payload: entity.payload,
      scheduledDate: entity.scheduledDate,
    );
  }

  factory NotificationModel.copyWithDifferentProps(
    NotificationEntity model, {
    String? id,
    int? groupId,
    String? title,
    String? body,
    String? payload,
    DateTime? scheduledDate,
  }) {
    return NotificationModel(
      id: id ?? model.id,
      groupId: groupId ?? model.groupId,
      title: title ?? model.title,
      body: body ?? model.body,
      payload: payload ?? model.payload,
      scheduledDate: scheduledDate ?? model.scheduledDate,
    );
  }
}
