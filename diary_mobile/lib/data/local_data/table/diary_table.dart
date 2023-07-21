import 'package:drift/drift.dart';

import '../../entity/diary/diary.dart';

@UseRowClass(Diary)
class DiaryTable extends Table {
  @override
  String get tableName => 'diary';

  IntColumn get id => integer().nullable()();
  IntColumn get seasonFarmId => integer().nullable()();
  IntColumn get activityId => integer().nullable()();
  TextColumn get user => text().nullable()();
  TextColumn get actionTime => text().nullable()();
  RealColumn get actionArea => real().nullable()();
  TextColumn get actionAreaUnitId => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get crop => text().nullable()();
  TextColumn get startDate => text().nullable()();
  TextColumn get endDate => text().nullable()();
  TextColumn get status => text().nullable()();
  RealColumn get amount => real().nullable()();
  TextColumn get amountUnitId => text().nullable()();
  RealColumn get area => real().nullable()();
  TextColumn get areaUnitId => text().nullable()();
  RealColumn get yieldEstimate => real().nullable()();
  TextColumn get yieldEstimateUnitId => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}

// List<Item> tool;
// List<Item> material;
// List<Item> media;