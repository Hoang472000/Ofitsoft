import 'dart:convert';
import 'package:diary_mobile/data/entity/report/answer.dart';
import 'package:diary_mobile/data/entity/report/report.dart';

class SurveyRpRlt {
  int? id;
  String? state;
  String? nickname;
  String? create_date;
  String? write_date;
  //
  List<Report> survey_id;
  //
  int? farmer_id;
  String? farmer;
  String? farmer_code;
  int? internal_inspector_id;
  String? internal_inspector;
  String? monitoring_visit_type;
  String? visit_date;

  SurveyRpRlt({
    this.id,
    this.state,
    this.nickname,
    this.create_date,
    this.write_date,
    this.farmer_id,
    this.farmer,
    this.farmer_code,
    this.internal_inspector_id,
    this.monitoring_visit_type,
    this.survey_id = const [],
    this.visit_date,
  });

  SurveyRpRlt.copy(SurveyRpRlt other)
      : id = other.id,
        state = other.state,
        nickname = other.nickname,
        create_date = other.create_date,
        write_date = other.write_date,
        farmer_id = other.farmer_id,
        farmer = other.farmer,
        farmer_code = other.farmer_code,
        internal_inspector_id = other.internal_inspector_id,
        monitoring_visit_type = other.monitoring_visit_type,
        survey_id = other.survey_id
            .map((answer) => Report.copy(answer))
            .toList(),
        visit_date = other.visit_date;

  factory SurveyRpRlt.fromJson(Map<String, dynamic> json) {
    return SurveyRpRlt(
      id: json['id'] ?? -1,
      state:  json['state'] ?? '',
      nickname: json['nickname'] ?? '',
      create_date: json['create_date'] ?? '',
      write_date: json['write_date'] ?? '',
      farmer_id: json['farmer_id'] ?? -1,
      farmer: json['farmer'] ?? '',
      farmer_code: json['farmer_code'] ?? '',
      internal_inspector_id: json['internal_inspector_id'] ?? -1,
      monitoring_visit_type: json['monitoring_visit_type'] ?? '',
      survey_id: json['survey_id'] != null
          ? (json['survey_id'] as List<dynamic>)
          .map((itemJson) => Report.fromJson(itemJson))
          .toList()
          : [],
      visit_date:
      jsonEncode(json['visit_date']) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state'] = state;
    data['nickname'] = nickname;
    data['create_date'] = create_date;
    data['write_date'] = write_date;
    data['farmer_id'] = farmer_id;
    data['farmer'] = farmer;
    data['farmer_code'] = farmer_code;
    data['internal_inspector_id'] = internal_inspector_id;
    data['monitoring_visit_type'] = monitoring_visit_type;
    data['survey_id'] = survey_id;
    data['visit_date'] = visit_date;
    return data;
  }
}
