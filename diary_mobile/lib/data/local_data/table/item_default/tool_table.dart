import 'package:diary_mobile/data/entity/item_default/tool.dart';
import 'package:drift/drift.dart';

@UseRowClass(Tool)
class ToolTable extends Table {
  @override
  String get tableName => 'tool';

  IntColumn get id => integer().nullable()();
  IntColumn get categoryId => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isOrganic => boolean().nullable()();
  BoolColumn get notation => boolean().nullable()();
  BoolColumn get isActive => boolean().nullable()();
  BoolColumn get image => boolean().nullable()();
  IntColumn get diaryFarmerId => integer().nullable()();
  IntColumn get toolId => integer().nullable()();
  IntColumn get quantity => integer().nullable()();
  TextColumn get unitId => text().nullable()();
  TextColumn get mediaContent => text().nullable()();
  @override
  Set<Column>? get primaryKey => {id};
}