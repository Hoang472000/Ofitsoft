import 'package:diary_mobile/data/entity/report/question_upload.dart';
import 'package:drift/drift.dart';


@UseRowClass(QuestionUpload)
class QuestionUploadNoNetworkTable extends Table {
  @override
  String get tableName => 'question_upload_no_network';

  TextColumn get api => text().nullable()();
  TextColumn get idOffline => text().nullable()();
  IntColumn get userInputId => integer().nullable()();
  IntColumn get surveyId => integer().nullable()();
  IntColumn get questionId => integer().nullable()();
  IntColumn get suggestedAnswerId => integer().nullable()();
  IntColumn get matrixRowId => integer().nullable()();
  TextColumn get answerType => text().nullable()();
  TextColumn get valueText => text().nullable()();
  TextColumn get state => text().nullable()();
  BoolColumn get skipped => boolean().nullable()();
  BoolColumn get isAnswerExist => boolean().nullable()();
  BoolColumn get valueCheckBox => boolean().nullable()();
  IntColumn get tableRowId => integer().nullable()();
  TextColumn get stringListIdSuggested => text().nullable()();

  IntColumn get farmerId => integer().nullable()();
  TextColumn get farmerCode => text().nullable()();
  IntColumn get farmId => integer().nullable()();
  TextColumn get farmCode => text().nullable()();
  IntColumn get internalInspectorId => integer().nullable()();
  TextColumn get monitoringVisitType => text().nullable()();
  TextColumn get visitDate => text().nullable()();

  @override
  Set<Column>? get primaryKey => {idOffline, questionId, suggestedAnswerId, tableRowId};
}