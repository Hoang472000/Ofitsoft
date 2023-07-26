import 'package:diary_mobile/data/entity/item_default/material_entity.dart';
import 'package:drift/drift.dart';


@UseRowClass(MaterialEntity)
class MaterialTable extends Table {
  @override
  String get tableName => 'material';

  IntColumn get id => integer().nullable()();
  IntColumn get categoryId => integer().nullable()();
  TextColumn get material => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isOrganic => boolean().nullable()();
  BoolColumn get notation => boolean().nullable()();
  BoolColumn get isActive => boolean().nullable()();
  TextColumn get image => text().nullable()();
  IntColumn get diaryFarmerId => integer().nullable()();
  IntColumn get toolId => integer().nullable()();
  RealColumn get quantity => real().nullable()();
  IntColumn get materialId => integer().nullable()();
  TextColumn get unitName => text().nullable()();
  TextColumn get mediaContent => text().nullable()();
  @override
  Set<Column>? get primaryKey => {id};
}