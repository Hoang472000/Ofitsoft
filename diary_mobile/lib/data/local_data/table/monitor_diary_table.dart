import 'package:drift/drift.dart';

import '../../entity/monitor/monitor_diary.dart';

@UseRowClass(MonitorDiary)
class MonitorDiaryTable extends Table {
  @override
  String get tableName => 'monitor_diary';

  IntColumn get id => integer().nullable()();
  IntColumn get seasonFarmId => integer().nullable()();
  TextColumn get seasonFarm => text().nullable()();
  TextColumn get actionTime => text().nullable()();
  TextColumn get latitude => text().nullable()();
  TextColumn get longitude => text().nullable()();
  IntColumn get monitorId => integer().nullable()();
  TextColumn get monitor => text().nullable()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}

