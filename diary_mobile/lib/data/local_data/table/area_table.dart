import 'package:diary_mobile/data/entity/diary/area_entity.dart';
import 'package:drift/drift.dart';

@UseRowClass(AreaEntity)
class AreaEntityTable extends Table {
  @override
  String get tableName => 'area_entity';

  IntColumn get userId => integer().nullable()();
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get stringSeasons => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id, userId};
}