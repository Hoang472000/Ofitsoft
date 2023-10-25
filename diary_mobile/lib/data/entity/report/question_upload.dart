import 'dart:convert';

import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:drift/drift.dart';

import '../../../utils/utils.dart';

class QuestionUpload implements Insertable<QuestionUpload> {
  String? api;
  String? idOffline;
  int? userInputId;
  int? surveyId;
  int? questionId;
  int? suggestedAnswerId;
  int? matrixRowId;
  String? answerType;
  String? valueText;
  String? state; // submit upload done or progress
  bool? skipped;

  bool? isAnswerExist;
  bool? valueCheckBox;
  int? tableRowId;
  List<int>? listIdSuggested;
  String? stringListIdSuggested;

  int? farmerId;
  String? farmerCode;
  int? farmId;
  String? farmCode;
  int? internalInspectorId;
  String? monitoringVisitType;
  String? visitDate;

  QuestionUpload({
    this.api,
    this.idOffline,
    this.userInputId,
    this.surveyId,
    this.questionId,
    this.suggestedAnswerId,
    this.matrixRowId,
    this.answerType,
    this.valueText,
    this.skipped,
    this.state,
    this.isAnswerExist,
    this.valueCheckBox,
    this.tableRowId,
    this.listIdSuggested,
    this.stringListIdSuggested,
    this.farmerId,
    this.farmerCode,
    this.internalInspectorId,
    this.monitoringVisitType,
    this.visitDate,
    this.farmId,
    this.farmCode,
  });

  factory QuestionUpload.fromJsonConvert(QuestionUpload json, String api) {
    return QuestionUpload(
      api: api,
      idOffline: json.idOffline,
      userInputId: json.userInputId,
      surveyId: json.surveyId,
      listIdSuggested: json.listIdSuggested,
      stringListIdSuggested: jsonEncode(json.listIdSuggested) ?? '[]',
      suggestedAnswerId: json.suggestedAnswerId,
      questionId: json.questionId,
      matrixRowId: json.matrixRowId,
      answerType: json.answerType,
      valueText: json.valueText,
      skipped: json.skipped,
      state: json.state,
      isAnswerExist: json.isAnswerExist,
      valueCheckBox: json.valueCheckBox,
      tableRowId: json.tableRowId,

      farmerId: json.farmerId,
      farmerCode: json.farmerCode,
      internalInspectorId: json.internalInspectorId,
      monitoringVisitType: json.monitoringVisitType,
      visitDate: json.visitDate,
      farmId: json.farmId,
      farmCode: json.farmCode,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_input_id'] = userInputId;
    data['survey_id'] = surveyId;
    data['question_id'] = questionId;
    data['suggested_answer_id'] = suggestedAnswerId;
    data['matrix_row_id'] = matrixRowId;
    data['answer_type'] = answerType;
    data['value_text'] = valueText;
    data['skipped'] = skipped;
    data['state'] = state;

    data['is_answer_exist'] = isAnswerExist;
    data['value_check_box'] = true;
    data['table_row_id'] = tableRowId;
    data['list_id_suggested'] = listIdSuggested;

    data['farmer_id'] = farmerId;
    data['farmer_code'] = farmerCode;
    data['farm_id'] = farmId;
    data['farm_code'] = farmCode;
    data['internal_inspector_id'] = internalInspectorId;
    data['monitoring_visit_type'] = monitoringVisitType;
    data['visit_date'] = visitDate;
    return data;
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return QuestionUploadNoNetworkTableCompanion(
      idOffline: Value(idOffline),
      api: Value(api),
      userInputId: Value(userInputId),
      surveyId: Value(surveyId),
      questionId: Value(questionId),
      suggestedAnswerId: Value(suggestedAnswerId),
      matrixRowId: Value(matrixRowId),
      answerType: Value(answerType),
      valueText: Value(valueText),
      skipped: Value(skipped),
      state: Value(state),
      isAnswerExist: Value(isAnswerExist),
      valueCheckBox: Value(valueCheckBox),
      tableRowId: Value(tableRowId),
      stringListIdSuggested: Value(stringListIdSuggested),
      farmerId: Value(farmerId),
      farmerCode: Value(farmerCode),
      farmId: Value(farmId),
      farmCode: Value(farmCode),
      internalInspectorId: Value(internalInspectorId),
      monitoringVisitType: Value(monitoringVisitType),
      visitDate: Value(visitDate),
    ).toColumns(nullToAbsent);
  }
}

class FarmerInspectorUpload implements Insertable<FarmerInspectorUpload> {
  String? api;
  String? idOffline;
  int? id;
  int? farmerId;
  String? farmerCode;
  int? farmId;
  String? farmCode;
  int? internalInspectorId;
  String? monitoringVisitType;
  String? visitDate;
  String? state;

  FarmerInspectorUpload({
    this.api,
    this.idOffline,
    this.id,
    this.farmerId,
    this.farmerCode,
    this.farmId,
    this.farmCode,
    this.internalInspectorId,
    this.monitoringVisitType,
    this.visitDate,
    this.state,
  });

  factory FarmerInspectorUpload.fromJsonConvert(FarmerInspectorUpload json, String api) {
    return FarmerInspectorUpload(
      api: api,
      id: json.id,
      idOffline: json.idOffline,
      farmerId: json.farmerId,
      farmerCode: json.farmerCode,
      farmId: json.farmId,
      internalInspectorId: json.internalInspectorId,
      monitoringVisitType: json.monitoringVisitType,
      visitDate: json.visitDate,
      state: json.state,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_offline'] = idOffline;
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['farm_id'] = farmId;
    data['internal_inspector_id'] = internalInspectorId;
    data['monitoring_visit_type'] = monitoringVisitType;
    data['visit_date'] = Utils.stringToFormattedString(visitDate ?? "");
    return data;
  }

  Map<String, dynamic> toJsonSubmit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state'] = state;
    return data;
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return FarmerInspectorUploadNoNetworkTableCompanion(
      api: Value(api),
      idOffline: Value(idOffline),
      farmerId: Value(farmerId),
      farmerCode: Value(farmerCode),
      farmId: Value(farmId),
      farmCode: Value(farmCode),
      internalInspectorId: Value(internalInspectorId),
      monitoringVisitType: Value(monitoringVisitType),
      visitDate: Value(visitDate),
    ).toColumns(nullToAbsent);
  }
}
