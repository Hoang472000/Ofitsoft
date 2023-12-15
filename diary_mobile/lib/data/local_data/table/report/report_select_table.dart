import 'package:drift/drift.dart';

import '../../../entity/report/report_select.dart';

@UseRowClass(ReportSelect)
class ReportSelectTable extends Table {
  @override
  String get tableName => 'report_select_table';

  IntColumn get id => integer().nullable()();
  TextColumn get title => text().nullable()();
  BoolColumn get isInitialAssessment => boolean().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}