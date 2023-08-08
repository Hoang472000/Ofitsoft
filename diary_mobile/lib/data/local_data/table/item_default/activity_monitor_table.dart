import 'package:diary_mobile/data/entity/item_default/activity_monitor.dart';
import 'package:drift/drift.dart';

@UseRowClass(ActivityMonitor)
class ActivityMonitorTable extends Table {
  @override
  String get tableName => 'activity';

  IntColumn get id => integer().nullable()();
  IntColumn get diaryMonitorId => integer().nullable()();
  IntColumn get activityId => integer().nullable()();
  TextColumn get activity => text().nullable()();
  BoolColumn get checkYes => boolean().nullable()();
  BoolColumn get checkNo => boolean().nullable()();
  TextColumn get image => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}