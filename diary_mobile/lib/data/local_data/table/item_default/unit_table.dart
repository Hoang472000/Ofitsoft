import 'package:diary_mobile/data/entity/item_default/unit.dart';
import 'package:drift/drift.dart';

@UseRowClass(Unit)
class UnitTable extends Table {
  @override
  String get tableName => 'unit';

  IntColumn get id => integer().nullable()();
  IntColumn get categoryId => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isOrganic => boolean().nullable()();
  BoolColumn get notation => boolean().nullable()();
  BoolColumn get isActive => boolean().nullable()();
  TextColumn get image => text().nullable()();
  IntColumn get diaryFarmerId => integer().nullable()();
  IntColumn get toolId => integer().nullable()();
  RealColumn get quantity => real().nullable()();
  RealColumn get convert => real().nullable()();
  IntColumn get unitId => integer().nullable()();
  TextColumn get mediaContent => text().nullable()();
  @override
  Set<Column>? get primaryKey => {id};
}