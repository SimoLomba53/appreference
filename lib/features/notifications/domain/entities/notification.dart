import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class NotificationEntity extends Equatable {
  //basic
  String? id;
  final int? groupId;
  final String? title;
  final String? body;
  final String? payload;
  DateTime? scheduledDate;

  NotificationEntity({
    this.id,
    this.groupId,
    this.title,
    this.body,
    this.payload,
    this.scheduledDate,
  }) {
    if (id == null || id!.isEmpty) {
      generateID();
    }
  }

  generateID() {
    id = (Random(13).nextInt(10000000).toString() +
            DateTime.now().toIso8601String())
        .replaceAll(' ', '');
  }

  generateIntID() {
    return Random(13).nextInt(10000000);
  }

  @override
  List<Object?> get props {
    return [
      id,
      groupId,
      title,
      body,
      payload,
      scheduledDate,
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupId': groupId,
      'title': title,
      'body': body,
      'payload': payload,
      'scheduledDate': scheduledDate!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
