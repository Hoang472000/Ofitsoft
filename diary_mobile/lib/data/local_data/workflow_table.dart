import 'package:drift/drift.dart';

import '../entity/workflow/workflow.dart';

@UseRowClass(Workflow)
class WorkflowTable extends Table {
  @override
  String get tableName => 'workflow';
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get cropName => text().nullable()();
  TextColumn get productName => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get standard => text().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get statusName => text().nullable()();
  TextColumn get stringProcessStageIds => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}