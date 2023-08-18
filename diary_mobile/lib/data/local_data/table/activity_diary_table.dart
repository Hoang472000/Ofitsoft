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
  TextColumn get activityName => text().nullable()();
  TextColumn get actionTime => text().nullable()();
  RealColumn get actionArea => real().nullable()();
  IntColumn get actionAreaUnitId => integer().nullable()();
  TextColumn get actionAreaUnitName => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isShow => boolean().nullable()();
  IntColumn get amountUnitId => integer().nullable()();
  TextColumn get amountUnitName => text().nullable()();
  RealColumn get amount => real().nullable()();
  BoolColumn get harvesting => boolean().nullable()();

  TextColumn get stringTool => text().nullable()();
  TextColumn get stringMaterial => text().nullable()();
  TextColumn get stringMedia => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}