import 'package:drift/drift.dart';

import '../../entity/diary/diary.dart';

@UseRowClass(Diary)
class DiaryTable extends Table {
  @override
  String get tableName => 'diary';

  IntColumn get id => integer().nullable()();
  IntColumn get userId => integer().nullable()();
  TextColumn get action => text().nullable()();
  TextColumn get name => text().nullable()();
  IntColumn get seasonId => integer().nullable()();
  TextColumn get seasonName => text().nullable()();
  IntColumn get farmId => integer().nullable()();
  TextColumn get farmName => text().nullable()();
  TextColumn get productName => text().nullable()();
  TextColumn get cropName => text().nullable()();
  IntColumn get productId => integer().nullable()();
  IntColumn get cropId => integer().nullable()();
  RealColumn get amount => real().nullable()();
  IntColumn get amountUnitId => integer().nullable()();
  TextColumn get amountUnitName => text().nullable()();
  RealColumn get area => real().nullable()();
  IntColumn get areaUnitId => integer().nullable()();
  TextColumn get areaUnitName => text().nullable()();
  RealColumn get yieldEstimate => real().nullable()();
  IntColumn get yieldEstimateUnitId => integer().nullable()();
  TextColumn get yieldEstimateUnitName => text().nullable()();
  RealColumn get yieldReal => real().nullable()();
  IntColumn get yieldRealUnitId => integer().nullable()();
  TextColumn get yieldRealUnitName => text().nullable()();
  BoolColumn get harvesting => boolean().nullable()();
  TextColumn get startDate => text().nullable()();
  TextColumn get endDate => text().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get statusName => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get farmerName => text().nullable()();
  IntColumn get farmerId => integer().nullable()();

  TextColumn get areaName => text().nullable()();
  TextColumn get areaCode => text().nullable()();
  TextColumn get farmCode => text().nullable()();
  TextColumn get googleMap => text().nullable()();
  IntColumn get productProcessId => integer().nullable()();
  TextColumn get productProcessName => text().nullable()();
  IntColumn get areaId => integer().nullable()();

  @override
  Set<Column>? get primaryKey => {id, userId};
}

// List<Item> tool;
// List<Item> material;
// List<Item> media;