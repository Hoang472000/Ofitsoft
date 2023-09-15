class ReportResult {
  int? id;
  String? surveyId;
  String? farm;
  String? inspector;
  String? date;

  ReportResult(
      {this.id,
        this.surveyId,
        this.farm,
        this.inspector,
        this.date});

  factory ReportResult.fromJson(Map<String, dynamic> json) {
    return ReportResult(
      id: json['id'] ?? -1,
      surveyId: json['survey_id'] ?? '',
      farm: json['farm'] ?? '',
      inspector: json['inspector'] ?? '',
      date: json['date'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['survey_id'] = surveyId;
    data['farm'] = farm;
    data['inspector'] = inspector;
    data['date'] = date;
    return data;
  }

}
