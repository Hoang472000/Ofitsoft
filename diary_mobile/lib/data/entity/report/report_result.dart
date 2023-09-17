class ReportResult {
  int? id;
  String? surveyId;
  int? farmerId;
  String? farmer;
  String? farmerCode;
  int? internalInspectorId;
  String? internalInspector;
  String? monitoringVisitType;
  String? createDate;
  ReportResult(
      {this.id,
        this.surveyId,
        this.farmerId,
        this.farmer,
        this.farmerCode,
        this.internalInspectorId,
        this.internalInspector,
        this.monitoringVisitType,
        this.createDate});

  factory ReportResult.fromJson(Map<String, dynamic> json) {
    return ReportResult(
      id: json['id'] ?? -1,
      surveyId: json['survey_id'] ?? '',
      farmerId: json['farmer_id'] ?? -1,
      farmer: json['farmer'] ?? '',
      farmerCode: json['farmer_code'] ?? '',
      internalInspectorId: json['internal_inspector_id'] ?? -1,
      internalInspector: json['internal_inspector'] ?? '',
      createDate: json['create_date'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['survey_id'] = surveyId;
    data['farmer_id'] = farmerId;
    data['farmer'] = farmer;
    data['farmer_code'] = farmerCode;
    data['internal_inspector_id'] = internalInspectorId;
    data['internal_inspector'] = internalInspector;
    data['create_date'] = createDate;
    return data;
  }

}
