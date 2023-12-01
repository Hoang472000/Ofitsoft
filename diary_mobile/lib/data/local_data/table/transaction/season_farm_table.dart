import 'package:diary_mobile/data/entity/activity/season_farm.dart';
import 'package:drift/drift.dart';

@UseRowClass(SeasonFarm)
class SeasonFarmTable extends Table {
  @override
  String get tableName => 'season_farm';

  IntColumn get id => integer().nullable()();
  IntColumn get userId => integer().nullable()();
  TextColumn get name => text().nullable()();
  IntColumn get productId => integer().nullable()();
  TextColumn get productName => text().nullable()();
  RealColumn get availableQuantity => real().nullable()();
  IntColumn get unitId => integer().nullable()();
  TextColumn get image => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}