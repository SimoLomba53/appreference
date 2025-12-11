import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:growingapp/core/util/list_dynamic_converter.dart';
import 'package:growingapp/features/notifications/data/repository/local/notification_repository_impl.dart';
import 'package:growingapp/features/terrarium/data/data_sources/local/app_database.dart';
import 'package:growingapp/features/terrarium/data/data_sources/terrarium_api_service.dart';
import 'package:growingapp/features/terrarium/data/repository/terrarium_repository_impl.dart';
import 'package:growingapp/features/worker/model/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:io' show Platform;

setup() {
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );
  if (Platform.isAndroid) {
    Workmanager().registerPeriodicTask("1", "simplePeriodicTask",
      frequency: const Duration(hours: 4),
    );
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // 1: Retrieve tasks from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksJson = prefs.getString('tasksNotification') ?? '[]';
    var tasks = listDynamicToType<TaskNotification>(
      jsonDecode(tasksJson)
          .map(
              (task) => TaskNotification.fromJson(task as Map<String, dynamic>))
          .toList(),
    );

    if (tasks.isEmpty) return Future.value(true);

    // 2: Check for tasks needing notification
    final int currentTimeInSeconds =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;
    List<TaskNotification> tasksForNotification = tasks
        .where((task) =>
            currentTimeInSeconds - task.lastNotificationTimeInSeconds >=
            task.maxTimeBetweenNotificationsInSeconds)
        .toList();

    if (tasksForNotification.isEmpty) return Future.value(true);

    // 3: Send Notifications to send
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    TerrariumRepositoryImpl terrariumRepository =
        TerrariumRepositoryImpl(TerrariumApiService(Dio()), database);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher_foreground');
    const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentList: true,
        defaultPresentBanner: true,
        defaultPresentSound: true,
      );
  const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    LocalNotificationRepositoryImpl localNotificationRepositoryImpl =
        LocalNotificationRepositoryImpl(database);

    for (TaskNotification task in tasksForNotification) {
      //verify if terrarium exists
      var localTerrariums = (await terrariumRepository.getSavedTerrariums())
          .where((t) => t.id == task.terrariumId);
      if (localTerrariums.isEmpty) continue;

      task.notification.generateID();

      //schedule notification
      flutterLocalNotificationsPlugin.show(
        task.notification.generateIntID(),
        task.notification.title,
        task.notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            groupKey: 'com.growingartterrariums.flutter_push_notifications',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            ticker: 'ticker',
          ),
        ),
      );
      task.notification.scheduledDate = DateTime.now();

      //save scheduled notification
      localNotificationRepositoryImpl.saveNotification(task.notification);

      // Update lastNotificationTimeInSeconds for the task
      task.lastNotificationTimeInSeconds = currentTimeInSeconds;
    }

    // 4: Save updated tasksNotification
    prefs.setString(
      'tasksNotification',
      jsonEncode(tasks.map((e) => e.toJson()).toList()),
    );

    return Future.value(true);
  });
}
