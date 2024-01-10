import 'package:diary_mobile/data/entity/task%20/task_entity.dart';
import 'package:drift/drift.dart';

@UseRowClass(TaskEntity)
class TaskEntityTable extends Table {
  @override
  String get tableName => 'task_entity';

  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get stringSeasonFarmIds => text().nullable()();
  IntColumn get activityId => integer().nullable()();
  TextColumn get activityName => text().nullable()();
  TextColumn get startDate => text().nullable()();
  TextColumn get endDate => text().nullable()();
  TextColumn get completeDate => text().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get statusName => text().nullable()();
  TextColumn get result => text().nullable()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}