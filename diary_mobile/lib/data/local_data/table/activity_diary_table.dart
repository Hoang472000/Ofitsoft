import 'package:drift/drift.dart';

import '../../entity/activity/activity_diary.dart';

@UseRowClass(ActivityDiary)
class ActivityDiaryTable extends Table {
  @override
  String get tableName => 'activity_diary';

  IntColumn get id => integer().nullable()();
  IntColumn get seasonFarmId => integer().nullable()();
  TextColumn get seasonFarm => text().nullable()();
  IntColumn get activityId => integer().nullable()();
  TextColumn get activity => text().nullable()();
  TextColumn get actionTime => text().nullable()();
  RealColumn get actionArea => real().nullable()();
  IntColumn get actionAreaUnitId => integer().nullable()();
  TextColumn get actionAreaUnit => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isShow => boolean().nullable()();

  TextColumn get name => text().nullable()();
  TextColumn get byName => text().nullable()();
  TextColumn get startTime => text().nullable()();
  TextColumn get endTime => text().nullable()();
  IntColumn get status => integer().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}

// List<Item> tool;
// List<Item> material;
// List<Item> media;