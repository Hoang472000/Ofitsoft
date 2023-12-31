class ReportResult {
  int? id;
  String? surveyId;
  int? farmerId;
  String? farmerName;
  String? farmerCode;
  int? farmId;
  String? farmName;
  String? farmCode;
  int? internalInspectorId;
  String? internalInspector;
  String? monitoringVisitType;
  String? createDate;
  String? state;
  bool? isInitialAssessment;
  ReportResult(
      {this.id,
        this.surveyId,
        this.farmerId,
        this.farmerName,
        this.farmerCode,
        this.farmId,
        this.farmName,
        this.farmCode,
        this.internalInspectorId,
        this.internalInspector,
        this.monitoringVisitType,
        this.state,
        this.createDate,
        this.isInitialAssessment
      });

  factory ReportResult.fromJson(Map<String, dynamic> json) {
    return ReportResult(
      id: json['id'] ?? -1,
      surveyId: json['survey_id'] ?? '',
      farmerId: json['farmer_id'] ?? -1,
      farmerName: json['farmer_name'] ?? '',
      farmerCode: json['farmer_code'] ?? '',
      farmId: json['farm_id'] ?? -1,
      farmName: json['farm_name'] ?? '',
      farmCode: json['farm_code'] == false  ? '': json['farm_code'] ?? '',
      internalInspectorId: json['internal_inspector_id'] ?? -1,
      internalInspector: json['internal_inspector'] ?? '',
      createDate: json['create_date'] ?? '',
      state: json['state'] == false ? 'in_progress' : json['state'] ?? 'in_progress',
      isInitialAssessment: json['is_initial_assessment'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['survey_id'] = surveyId;
    data['farmer_id'] = farmerId;
    data['farmer_name'] = farmerName;
    data['farmer_code'] = farmerCode;
    data['farm_id'] = farmId;
    data['farm_name'] = farmName;
    data['farm_code'] = farmCode;
    data['internal_inspector_id'] = internalInspectorId;
    data['internal_inspector'] = internalInspector;
    data['create_date'] = createDate;
    data['state'] = state;
    data['is_initial_assessment'] = isInitialAssessment;
    return data;
  }

  ReportResult.copy(ReportResult other)
      : id = other.id,
        surveyId = other.surveyId,
        farmerId = other.farmerId,
        farmerName = other.farmerName,
        farmerCode = other.farmerCode,
        farmId = other.farmId,
        farmName = other.farmName,
        farmCode = other.farmCode,
        internalInspectorId = other.internalInspectorId,
        internalInspector = other.internalInspector,
        createDate = other.createDate,
        state = other.state,
        isInitialAssessment = other.isInitialAssessment;
}
