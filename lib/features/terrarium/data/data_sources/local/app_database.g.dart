// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TerrariumDao? _terrariumDAOInstance;

  NotificationDao? _notificationDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `terrarium` (`id` TEXT, `concept` TEXT, `description` TEXT, `imgUrl` TEXT, `imgNoBackgroundUrl` TEXT, `difficulty` TEXT, `minLux` REAL, `minPerfectLux` REAL, `maxPerfectLux` REAL, `maxLux` REAL, `plants` TEXT, `guides` TEXT, `canVariate` INTEGER, `canHaveWood` INTEGER, `needWatering` INTEGER, `name` TEXT, `actualPlants` TEXT, `haveWood` INTEGER, `wateringNotificationsEnabled` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `notification` (`id` TEXT, `groupId` INTEGER, `title` TEXT, `body` TEXT, `payload` TEXT, `scheduledDate` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TerrariumDao get terrariumDAO {
    return _terrariumDAOInstance ??= _$TerrariumDao(database, changeListener);
  }

  @override
  NotificationDao get notificationDAO {
    return _notificationDAOInstance ??=
        _$NotificationDao(database, changeListener);
  }
}

class _$TerrariumDao extends TerrariumDao {
  _$TerrariumDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _terrariumModelInsertionAdapter = InsertionAdapter(
            database,
            'terrarium',
            (TerrariumModel item) => <String, Object?>{
                  'id': item.id,
                  'concept': item.concept,
                  'description': item.description,
                  'imgUrl': item.imgUrl,
                  'imgNoBackgroundUrl': item.imgNoBackgroundUrl,
                  'difficulty': item.difficulty,
                  'minLux': item.minLux,
                  'minPerfectLux': item.minPerfectLux,
                  'maxPerfectLux': item.maxPerfectLux,
                  'maxLux': item.maxLux,
                  'plants': _stringListConverter.encode(item.plants),
                  'guides': _stringListConverter.encode(item.guides),
                  'canVariate': item.canVariate == null
                      ? null
                      : (item.canVariate! ? 1 : 0),
                  'canHaveWood': item.canHaveWood == null
                      ? null
                      : (item.canHaveWood! ? 1 : 0),
                  'needWatering': item.needWatering == null
                      ? null
                      : (item.needWatering! ? 1 : 0),
                  'name': item.name,
                  'actualPlants':
                      _stringListConverter.encode(item.actualPlants),
                  'haveWood':
                      item.haveWood == null ? null : (item.haveWood! ? 1 : 0),
                  'wateringNotificationsEnabled':
                      item.wateringNotificationsEnabled == null
                          ? null
                          : (item.wateringNotificationsEnabled! ? 1 : 0)
                }),
        _terrariumModelUpdateAdapter = UpdateAdapter(
            database,
            'terrarium',
            ['id'],
            (TerrariumModel item) => <String, Object?>{
                  'id': item.id,
                  'concept': item.concept,
                  'description': item.description,
                  'imgUrl': item.imgUrl,
                  'imgNoBackgroundUrl': item.imgNoBackgroundUrl,
                  'difficulty': item.difficulty,
                  'minLux': item.minLux,
                  'minPerfectLux': item.minPerfectLux,
                  'maxPerfectLux': item.maxPerfectLux,
                  'maxLux': item.maxLux,
                  'plants': _stringListConverter.encode(item.plants),
                  'guides': _stringListConverter.encode(item.guides),
                  'canVariate': item.canVariate == null
                      ? null
                      : (item.canVariate! ? 1 : 0),
                  'canHaveWood': item.canHaveWood == null
                      ? null
                      : (item.canHaveWood! ? 1 : 0),
                  'needWatering': item.needWatering == null
                      ? null
                      : (item.needWatering! ? 1 : 0),
                  'name': item.name,
                  'actualPlants':
                      _stringListConverter.encode(item.actualPlants),
                  'haveWood':
                      item.haveWood == null ? null : (item.haveWood! ? 1 : 0),
                  'wateringNotificationsEnabled':
                      item.wateringNotificationsEnabled == null
                          ? null
                          : (item.wateringNotificationsEnabled! ? 1 : 0)
                }),
        _terrariumModelDeletionAdapter = DeletionAdapter(
            database,
            'terrarium',
            ['id'],
            (TerrariumModel item) => <String, Object?>{
                  'id': item.id,
                  'concept': item.concept,
                  'description': item.description,
                  'imgUrl': item.imgUrl,
                  'imgNoBackgroundUrl': item.imgNoBackgroundUrl,
                  'difficulty': item.difficulty,
                  'minLux': item.minLux,
                  'minPerfectLux': item.minPerfectLux,
                  'maxPerfectLux': item.maxPerfectLux,
                  'maxLux': item.maxLux,
                  'plants': _stringListConverter.encode(item.plants),
                  'guides': _stringListConverter.encode(item.guides),
                  'canVariate': item.canVariate == null
                      ? null
                      : (item.canVariate! ? 1 : 0),
                  'canHaveWood': item.canHaveWood == null
                      ? null
                      : (item.canHaveWood! ? 1 : 0),
                  'needWatering': item.needWatering == null
                      ? null
                      : (item.needWatering! ? 1 : 0),
                  'name': item.name,
                  'actualPlants':
                      _stringListConverter.encode(item.actualPlants),
                  'haveWood':
                      item.haveWood == null ? null : (item.haveWood! ? 1 : 0),
                  'wateringNotificationsEnabled':
                      item.wateringNotificationsEnabled == null
                          ? null
                          : (item.wateringNotificationsEnabled! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TerrariumModel> _terrariumModelInsertionAdapter;

  final UpdateAdapter<TerrariumModel> _terrariumModelUpdateAdapter;

  final DeletionAdapter<TerrariumModel> _terrariumModelDeletionAdapter;

  @override
  Future<List<TerrariumModel>> getTerrariums() async {
    return _queryAdapter.queryList('SELECT * FROM terrarium',
        mapper: (Map<String, Object?> row) => TerrariumModel(
            id: row['id'] as String?,
            concept: row['concept'] as String?,
            description: row['description'] as String?,
            difficulty: row['difficulty'] as String?,
            imgUrl: row['imgUrl'] as String?,
            imgNoBackgroundUrl: row['imgNoBackgroundUrl'] as String?,
            minLux: row['minLux'] as double?,
            minPerfectLux: row['minPerfectLux'] as double?,
            maxPerfectLux: row['maxPerfectLux'] as double?,
            maxLux: row['maxLux'] as double?,
            plants: _stringListConverter.decode(row['plants'] as String?),
            guides: _stringListConverter.decode(row['guides'] as String?),
            canVariate: row['canVariate'] == null
                ? null
                : (row['canVariate'] as int) != 0,
            canHaveWood: row['canHaveWood'] == null
                ? null
                : (row['canHaveWood'] as int) != 0,
            needWatering: row['needWatering'] == null
                ? null
                : (row['needWatering'] as int) != 0,
            name: row['name'] as String?,
            actualPlants:
                _stringListConverter.decode(row['actualPlants'] as String?),
            haveWood:
                row['haveWood'] == null ? null : (row['haveWood'] as int) != 0,
            wateringNotificationsEnabled:
                row['wateringNotificationsEnabled'] == null
                    ? null
                    : (row['wateringNotificationsEnabled'] as int) != 0));
  }

  @override
  Future<void> insertTerrarium(TerrariumModel terrarium) async {
    await _terrariumModelInsertionAdapter.insert(
        terrarium, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTerrarium(TerrariumModel terrarium) async {
    await _terrariumModelUpdateAdapter.update(
        terrarium, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteTerrarium(TerrariumModel terrarium) async {
    await _terrariumModelDeletionAdapter.delete(terrarium);
  }
}

class _$NotificationDao extends NotificationDao {
  _$NotificationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _notificationModelInsertionAdapter = InsertionAdapter(
            database,
            'notification',
            (NotificationModel item) => <String, Object?>{
                  'id': item.id,
                  'groupId': item.groupId,
                  'title': item.title,
                  'body': item.body,
                  'payload': item.payload,
                  'scheduledDate': _dateTimeConverter.encode(item.scheduledDate)
                }),
        _notificationModelUpdateAdapter = UpdateAdapter(
            database,
            'notification',
            ['id'],
            (NotificationModel item) => <String, Object?>{
                  'id': item.id,
                  'groupId': item.groupId,
                  'title': item.title,
                  'body': item.body,
                  'payload': item.payload,
                  'scheduledDate': _dateTimeConverter.encode(item.scheduledDate)
                }),
        _notificationModelDeletionAdapter = DeletionAdapter(
            database,
            'notification',
            ['id'],
            (NotificationModel item) => <String, Object?>{
                  'id': item.id,
                  'groupId': item.groupId,
                  'title': item.title,
                  'body': item.body,
                  'payload': item.payload,
                  'scheduledDate': _dateTimeConverter.encode(item.scheduledDate)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NotificationModel> _notificationModelInsertionAdapter;

  final UpdateAdapter<NotificationModel> _notificationModelUpdateAdapter;

  final DeletionAdapter<NotificationModel> _notificationModelDeletionAdapter;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    return _queryAdapter.queryList('SELECT * FROM notification',
        mapper: (Map<String, Object?> row) => NotificationModel(
            id: row['id'] as String?,
            groupId: row['groupId'] as int?,
            title: row['title'] as String?,
            body: row['body'] as String?,
            payload: row['payload'] as String?,
            scheduledDate:
                _dateTimeConverter.decode(row['scheduledDate'] as int?)));
  }

  @override
  Future<void> insertNotification(NotificationModel notification) async {
    await _notificationModelInsertionAdapter.insert(
        notification, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNotification(NotificationModel notification) async {
    await _notificationModelUpdateAdapter.update(
        notification, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteNotification(NotificationModel notification) async {
    await _notificationModelDeletionAdapter.delete(notification);
  }
}

// ignore_for_file: unused_element
final _stringListConverter = StringListConverter();
final _dateTimeConverter = DateTimeConverter();
