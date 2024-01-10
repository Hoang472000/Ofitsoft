import 'package:diary_mobile/data/entity/report/report.dart';
import 'package:drift/drift.dart';

@UseRowClass(Report)
class ReportTable extends Table {
  @override
  String get tableName => 'report';

  IntColumn get id => integer().nullable()();
  BoolColumn get isPage => boolean().nullable()();
  IntColumn get pageId => integer().nullable()();
  IntColumn get surveyId => integer().nullable()();
  TextColumn get title => text().nullable()();
  IntColumn get userId => integer().nullable()();
  BoolColumn get active => boolean().nullable()();
  BoolColumn get hasConditionalQuestions => boolean().nullable()();
  TextColumn get questionsSelection => text().nullable()();
  RealColumn get timeLimit => real().nullable()();
  TextColumn get stringQuestionAndPageIds => text().nullable()();
  TextColumn get stringListFarmers => text().nullable()();
  BoolColumn get isInitialAssessment => boolean().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}