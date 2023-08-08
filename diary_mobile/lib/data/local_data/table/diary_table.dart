import 'package:drift/drift.dart';

import '../../entity/diary/diary.dart';

@UseRowClass(Diary)
class DiaryTable extends Table {
  @override
  String get tableName => 'diary';

  IntColumn get id => integer().nullable()();
  IntColumn get seasonId => integer().nullable()();
  IntColumn get seasonFarmId => integer().nullable()();
  TextColumn get activity => text().nullable()();
  IntColumn get farmId => integer().nullable()();
  TextColumn get farm => text().nullable()();
  IntColumn get activityId => integer().nullable()();
  TextColumn get productName => text().nullable()();
  TextColumn get cropName => text().nullable()();
  IntColumn get productId => integer().nullable()();
  TextColumn get user => text().nullable()();
  TextColumn get actionTime => text().nullable()();
  RealColumn get actionArea => real().nullable()();
  IntColumn get actionAreaUnitId => integer().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get crop => text().nullable()();
  TextColumn get startDate => text().nullable()();
  TextColumn get endDate => text().nullable()();
  TextColumn get status => text().nullable()();
  RealColumn get amount => real().nullable()();
  IntColumn get amountUnitId => integer().nullable()();
  TextColumn get amountUnit => text().nullable()();
  RealColumn get area => real().nullable()();
  IntColumn get areaUnitId => integer().nullable()();
  TextColumn get areaUnit => text().nullable()();
  RealColumn get farmArea => real().nullable()();
  IntColumn get farmAreaUnitId => integer().nullable()();
  TextColumn get farmAreaUnit => text().nullable()();
  RealColumn get yieldEstimate => real().nullable()();
  IntColumn get yieldEstimateUnitId => integer().nullable()();
  TextColumn get yieldEstimateUnit => text().nullable()();
  TextColumn get farmerName => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}

// List<Item> tool;
// List<Item> material;
// List<Item> media;