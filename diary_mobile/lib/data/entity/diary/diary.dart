class Diary {
  int id;
  String name;
  String farmName;
  String farmCode;
  String farmerName;
  String? address;
  double area;
  String? areaUnitName;
  double? estimateYield;
  String? yieldUnitName;
  String? productName;
  String? startDate;
  String? endDate;
  String? description;
  String status;

  Diary({
    required this.id,
    required this.name,
    required this.farmName,
    required this.farmCode,
    required this.farmerName,
    this.address,
    required this.area,
    this.areaUnitName,
    this.estimateYield,
    this.yieldUnitName,
    this.productName,
    this.startDate,
    this.endDate,
    this.description,
    required this.status
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'] as int,
      name: json['name'],
      farmName: json['farmName'],
      farmCode: json['farm_code'],
      farmerName: json['farmer_name'],
      address: json['address'] ?? '',
      area: json['area'] ?? 0,
      areaUnitName: json['area_unit_name'] ?? '',
      estimateYield: json['estimate_yield'] ?? 0,
      yieldUnitName: json['yield_unit_name'] ?? '',
      productName: json['product_name'] ?? '',
      status: json['status'],
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    return data;
  }
}

class SearchDiary {
  int id;
  String keyword;

  SearchDiary({
    required this.id,
    required this.keyword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyword'] = this.keyword;
    return data;
  }
}