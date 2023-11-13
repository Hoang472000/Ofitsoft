import 'package:drift/drift.dart';

import '../../../entity/activity/no_network/activity_transaction_no_network.dart';

@UseRowClass(ActivityTransactionNoNetwork)
class ActivityTransactionNoNetworkTable extends Table {
  @override
  String get tableName => 'activity_transaction_no_network';

  TextColumn get api => text().nullable()();
  TextColumn get uuid => text().nullable()();
  IntColumn get id => integer().nullable()();
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

  @override
  Set<Column>? get primaryKey => {id, uuid};
}