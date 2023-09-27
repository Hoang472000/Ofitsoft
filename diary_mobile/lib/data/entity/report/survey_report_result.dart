import 'dart:convert';
import 'package:diary_mobile/data/entity/report/answer.dart';
import 'package:diary_mobile/data/entity/report/report.dart';

class SurveyRpRlt {
  int? id;
  String? state;
  String? nickname;
  String? createDate;
  String? writeDate;
  //
  List<Report> surveyId;
  //
  int? farmerId;
  String? farmer;
  String? farmerCode;
  int? internalInspectorId;
  String? internalInspector;
  String? monitoringVisitType;
  String? visitDate;
  List<People> listFarmers;
  List<People> listInternalInspector;
  List<MonitoringVisitType> listMonitoringVisitType;

  SurveyRpRlt({
    this.id,
    this.state,
    this.nickname,
    this.createDate,
    this.writeDate,
    this.farmerId,
    this.farmer,
    this.farmerCode,
    this.internalInspectorId,
    this.monitoringVisitType,
    this.surveyId = const [],
    this.visitDate,
    //
    this.listFarmers = const [],
    this.listInternalInspector = const [],
    this.listMonitoringVisitType = const [],
  });

  SurveyRpRlt.copy(SurveyRpRlt other)
      : id = other.id,
        state = other.state,
        nickname = other.nickname,
        createDate = other.createDate,
        writeDate = other.writeDate,
        farmerId = other.farmerId,
        farmer = other.farmer,
        farmerCode = other.farmerCode,
        internalInspectorId = other.internalInspectorId,
        monitoringVisitType = other.monitoringVisitType,
        surveyId = other.surveyId
            .map((answer) => Report.copy(answer))
            .toList(),
        visitDate = other.visitDate,
        listFarmers = other.listFarmers
            .map((answer) => People.copy(answer))
            .toList(),
        listInternalInspector = other.listInternalInspector
            .map((answer) => People.copy(answer))
            .toList(),
        listMonitoringVisitType = other.listMonitoringVisitType
            .map((answer) => MonitoringVisitType.copy(answer))
            .toList();

  factory SurveyRpRlt.fromJson(Map<String, dynamic> json) {
    return SurveyRpRlt(
      id: json['id'] ?? -1,
      state:  json['state'] ?? '',
      nickname: json['nickname'] ?? '',
      createDate: json['create_date'] ?? '',
      writeDate: json['write_date'] ?? '',
      farmerId: json['farmer_id'],
      farmer: json['farmer'] ?? '',
      farmerCode: json['farmer_code'] ?? '',
      internalInspectorId: json['internal_inspector_id'],
      monitoringVisitType: json['monitoring_visit_type'] ?? '',
      surveyId: json['survey_id'] != null
          ? (json['survey_id'] as List<dynamic>)
          .map((itemJson) => Report.fromJson(itemJson))
          .toList()
          : [],
      visitDate: json['visit_date'] ?? '',
      listFarmers: json['list_farmers'] != null
          ? (json['list_farmers'] as List<dynamic>)
          .map((itemJson) => People.fromJson(itemJson))
          .toList()
          : [],

      listInternalInspector: json['list_internal_inspector'] != null
          ? (json['list_internal_inspector'] as List<dynamic>)
          .map((itemJson) => People.fromJson(itemJson))
          .toList()
          : [],

      listMonitoringVisitType: json['list_monitoring_visit_type'] != null
          ? (json['list_monitoring_visit_type'] as List<dynamic>)
          .map((itemJson) => MonitoringVisitType.fromJson(itemJson))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state'] = state;
    data['nickname'] = nickname;
    data['create_date'] = createDate;
    data['write_date'] = writeDate;
    data['farmer_id'] = farmerId;
    data['farmer'] = farmer;
    data['farmer_code'] = farmerCode;
    data['internal_inspector_id'] = internalInspectorId;
    data['monitoring_visit_type'] = monitoringVisitType;
    data['survey_id'] = surveyId;
    data['visit_date'] = visitDate;
    data['list_farmers'] = listFarmers;
    data['list_internal_inspector'] = listInternalInspector;
    data['list_monitoring_visit_type'] = listMonitoringVisitType;
    return data;
  }
}
