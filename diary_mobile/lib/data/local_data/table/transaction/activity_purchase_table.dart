import 'package:drift/drift.dart';

import '../../../entity/activity/activity_purchase.dart';

@UseRowClass(ActivityPurchase)
class ActivityPurchaseTable extends Table {
  @override
  String get tableName => 'activity_purchase';

  IntColumn get id => integer().nullable()();
  TextColumn get uuid => text().nullable()();
  IntColumn get userId => integer().nullable()();
  IntColumn get seasonFarmId => integer().nullable()();
  TextColumn get seasonFarmName => text().nullable()();
  TextColumn get transactionDate => text().nullable()();
  RealColumn get quantity => real().nullable()();
  IntColumn get quantityUnitId => integer().nullable()();
  TextColumn get quantityUnitName => text().nullable()();
  IntColumn get productId => integer().nullable()();
  TextColumn get productName => text().nullable()();
  RealColumn get unitPrice => real().nullable()();
  BoolColumn get isPurchase => boolean().nullable()();
  TextColumn get person => text().nullable()();
  TextColumn get farmerName => text().nullable()();
  TextColumn get farmerCode => text().nullable()();
  TextColumn get areaName => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id, userId, uuid};
}