import 'dart:async';

import 'package:floor/floor.dart';
import 'package:growingapp/features/notifications/data/data_sources/DAO/notification_dao.dart';
import 'package:growingapp/features/notifications/data/models/notification.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:growingapp/core/util/type_converter.dart';
import 'package:growingapp/features/terrarium/data/data_sources/local/DAO/terrarium_dao.dart';
import 'package:growingapp/features/terrarium/data/models/terrarium.dart';
part 'app_database.g.dart';

@TypeConverters([StringListConverter, DateTimeConverter])
@Database(version: 1, entities: [TerrariumModel, NotificationModel])
abstract class AppDatabase extends FloorDatabase {
  TerrariumDao get terrariumDAO;
  NotificationDao get notificationDAO;
}
