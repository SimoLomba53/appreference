import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:growingapp/features/guide/data/data_sources/guide_api_service.dart';
import 'package:growingapp/features/guide/data/repository/guide_repository_impl.dart';
import 'package:growingapp/features/guide/domain/repository/guides_repository.dart';
import 'package:growingapp/features/guide/domain/usecases/get_guides.dart';
import 'package:growingapp/features/guide/presentation/bloc/guide/remote/remote_guide_bloc.dart';
import 'package:growingapp/features/notifications/data/repository/local/notification_repository_impl.dart';
import 'package:growingapp/features/notifications/data/repository/notification_repository_impl.dart';
import 'package:growingapp/features/notifications/domain/repository/local/notifications_repository.dart';
import 'package:growingapp/features/notifications/domain/repository/notifications_repository.dart';
import 'package:growingapp/features/notifications/domain/usecases/cancel_notification.dart';
import 'package:growingapp/features/notifications/domain/usecases/local/get_saved_notifications.dart';
import 'package:growingapp/features/notifications/domain/usecases/local/remove_notification.dart';
import 'package:growingapp/features/notifications/domain/usecases/local/save_notification.dart';
import 'package:growingapp/features/notifications/domain/usecases/local/update_notification.dart';
import 'package:growingapp/features/notifications/domain/usecases/schedule_notification.dart';
import 'package:growingapp/features/notifications/presentation/bloc/local/local_notification_bloc.dart';
import 'package:growingapp/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:growingapp/features/terrarium/data/data_sources/local/app_database.dart';
import 'package:growingapp/features/terrarium/data/data_sources/terrarium_api_service.dart';
import 'package:growingapp/features/terrarium/data/repository/terrarium_repository_impl.dart';
import 'package:growingapp/features/terrarium/domain/repository/terrariums_repository.dart';
import 'package:growingapp/features/terrarium/domain/usecases/get_saved_terrariums.dart';
import 'package:growingapp/features/terrarium/domain/usecases/get_terrariums.dart';
import 'package:growingapp/features/terrarium/domain/usecases/remove_terrarium.dart';
import 'package:growingapp/features/terrarium/domain/usecases/save_terrarium.dart';
import 'package:growingapp/features/terrarium/domain/usecases/update_terrarium.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_bloc.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/remote/remote_terrarium_bloc.dart';
import 'package:growingapp/features/worker/setup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final sl = GetIt.instance;

Future<void> inizializeDependencies() async {
  //DB init
  await initDB();

  //Local Notification init
  await initLocalNotifications();

  //Workmanager
  initWorker();

  //Dio
  sl.registerSingleton<Dio>(Dio());

  //Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Local Notification init
  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  //Dependencies
  sl.registerSingleton<TerrariumApiService>(TerrariumApiService(sl()));
  sl.registerSingleton<GuideApiService>(GuideApiService(sl()));
  sl.registerSingleton<NotificationRepository>(
      NotificationRepositoryImpl(sl()));
  sl.registerSingleton<TerrariumRepository>(
      TerrariumRepositoryImpl(sl(), sl()));
  sl.registerSingleton<GuideRepository>(GuideRepositoryImpl(sl()));
  sl.registerSingleton<LocalNotificationRepository>(
      LocalNotificationRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<GetTerrariumsUseCase>(GetTerrariumsUseCase(sl()));
  sl.registerSingleton<GetGuidesUseCase>(GetGuidesUseCase(sl()));
  sl.registerSingleton<ScheduleNotificationUseCase>(
      ScheduleNotificationUseCase(sl()));
  sl.registerSingleton<CancelNotificationUseCase>(
      CancelNotificationUseCase(sl()));

  sl.registerSingleton<GetSavedTerrariumsUseCase>(
      GetSavedTerrariumsUseCase(sl()));
  sl.registerSingleton<SaveTerrariumUseCase>(SaveTerrariumUseCase(sl()));
  sl.registerSingleton<RemoveTerrariumUseCase>(RemoveTerrariumUseCase(sl()));
  sl.registerSingleton<UpdateTerrariumUseCase>(UpdateTerrariumUseCase(sl()));
  sl.registerSingleton<GetSavedNotificationsUseCase>(
      GetSavedNotificationsUseCase(sl()));
  sl.registerSingleton<SaveNotificationUseCase>(SaveNotificationUseCase(sl()));
  sl.registerSingleton<RemoveNotificationUseCase>(
      RemoveNotificationUseCase(sl()));
  sl.registerSingleton<UpdateNotificationUseCase>(
      UpdateNotificationUseCase(sl()));

  //Blocs
  sl.registerFactory<RemoteTerrariumsBloc>(() => RemoteTerrariumsBloc(sl()));
  sl.registerFactory<RemoteGuidesBloc>(() => RemoteGuidesBloc(sl()));
  sl.registerFactory<NotificationBloc>(() => NotificationBloc(sl(), sl()));
  sl.registerFactory<LocalTerrariumsBloc>(
      () => LocalTerrariumsBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<LocalNotificationsBloc>(
      () => LocalNotificationsBloc(sl(), sl(), sl(), sl()));
}

initDB() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
}

initLocalNotifications() async {
  sl.registerSingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin());
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
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
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await sl<FlutterLocalNotificationsPlugin>()
      .initialize(initializationSettings);
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Europe/Rome'));
  if (Platform.isIOS) {
    final bool? result = await sl<FlutterLocalNotificationsPlugin>()
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  } else {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }
}

initWorker() {
  setup();
}
