import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:diary_mobile/utils/constants/name_icon.dart';
import 'package:drift/drift.dart';

import '../image/image_entity.dart';
import '../item_default/item_default.dart';
import '../item_default/material_entity.dart';
import '../item_default/tool.dart';

class Diary implements Insertable<Diary> {
  //Thuoc tinh information detail diary
  int? userId;
  String? action;
  int? id;
  String? name;
  int? seasonId;
  String? seasonName;
  int? farmId;
  String? farmName;
  int? cropId;
  String? cropName;
  int? productId;
  String? productName;
  double? area;
  int? areaUnitId;
  String? areaUnitName;
  double? amount;
  int? amountUnitId;
  String? amountUnitName;
  double? yieldEstimate;
  int? yieldEstimateUnitId;
  String? yieldEstimateUnitName;
  double? yieldReal;
  int? yieldRealUnitId;
  String? yieldRealUnitName;
  bool? harvesting;
  String? startDate;
  String? endDate;
  String? description;
  String? status;
  String? statusName;
  int? farmerId;
  String? farmerName;
  String? areaName;
  String? areaCode;
  String? farmCode;
  String? googleMap;
  int? productProcessId;
  String? productProcessName;
  int? areaId;
  String? image;

  Diary({
    this.userId,
    this.action,
    this.id,
    this.name,
    this.seasonId,
    this.seasonName,
    this.farmId,
    this.farmName,
    this.cropId,
    this.productName,
    this.cropName,
    this.productId,
    this.area,
    this.areaUnitId,
    this.areaUnitName,
    this.amount,
    this.amountUnitId,
    this.amountUnitName,
    this.yieldEstimate,
    this.yieldEstimateUnitId,
    this.yieldEstimateUnitName,
    this.yieldReal,
    this.yieldRealUnitId,
    this.yieldRealUnitName,
    this.harvesting,
    this.startDate,
    this.endDate,
    this.description,
    this.status,
    this.statusName,
    this.farmerName,
    this.farmerId,
    this.areaName,
    this.areaCode,
    this.farmCode,
    this.googleMap,
    this.productProcessId,
    this.productProcessName,
    this.areaId,
    this.image,
  });

  factory Diary.fromJson(Map<String, dynamic> json, int userId, String action) {
    return Diary(
      id: json['id'] ?? -1,
      userId: userId,
      action: action,
      name: json['name'] ?? "",
      seasonId: json['season_id'] ?? -1,
      seasonName: json['season_name'] ?? "",
      farmName: json['farm_name'] ?? '',
      farmId: json['farm_id'] ?? -1,
      cropId: json['crop_id'] ?? -1,
      cropName: json['crop_name'] ?? "",
      productId: json['product_id'] ?? -1,
      productName: json['product_name'] ?? "",
      areaUnitId: json['area_unit_id'] ?? -1,
      areaUnitName: json['area_unit_name'] ?? '',
      area: json['area'] ?? -1,
      amountUnitId: json['amount_unit_id'] ?? -1,
      amountUnitName: json['amount_unit_name'] ?? "",
      amount: json['amount'] ?? -1,
      yieldEstimateUnitId: json['yield_estimate_unit_id'] ?? -1,
      yieldEstimateUnitName: json['yield_estimate_unit_name'] ?? '',
      yieldEstimate: json['yield_estimate'] ?? -1,
      harvesting: json["harvesting"] ?? false,
      yieldReal: json["yield_real"] ?? -1,
      yieldRealUnitId: json["yield_real_unit_id"] ?? -1,
      yieldRealUnitName: json["yield_real_unit_name"] ?? '',
      startDate: json['start_date'] ?? "",
      endDate: json['end_date'] ?? "",
      description: json['description'] ?? '',
      status: json['status'] ?? "",
      statusName: json['status_name'] ?? "",
      farmerName: json['farmer_name'] ?? '',
      farmerId: json['farmer_id'] ?? -1,
      areaName: json['area_name'] ?? '',
      areaCode: json['area_code'] ?? '',
      farmCode: json['farm_code'] ?? '',
      googleMap: json['google_map'] ?? '',
      productProcessId: json['product_process_id'] ?? -1,
      productProcessName: json['product_process_name'] ?? '',
      areaId: json['area_id'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['action'] = action;
    data['name'] = name;
    data['season_id'] = seasonId;
    data['season_name'] = seasonName;
    data['farm_name'] = farmName;
    data['farm_id'] = farmId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['crop_name'] = cropName;
    data['crop_id'] = cropId;
    data['amount'] = amount;
    data['amount_unit_name'] = amountUnitName;
    data['amount_unit_id'] = amountUnitId;
    data['area'] = area;
    data['area_unit_id'] = areaUnitId;
    data['area_unit_name'] = areaUnitName;
    data['yield_estimate'] = yieldEstimate;
    data['yield_estimate_unit_name'] = yieldEstimateUnitName;
    data['yield_estimate_unit_id'] = yieldEstimateUnitId;
    data['yield_real'] = yieldReal;
    data['yield_real_unit_name'] = yieldRealUnitName;
    data['yield_real_unit_id'] = yieldRealUnitId;
    data['harvesting'] = harvesting;
    data['description'] = description;
    data['start_time'] = startDate;
    data['end_time'] = endDate;
    data['status'] = status;
    data['status_name'] = statusName;
    data['area_name'] = areaName;
    data['area_code'] = areaCode;
    data['farmer_name'] = farmerName;
    data['farmer_id'] = farmerId;
    data['farm_code'] = farmCode;
    data['google_map'] = googleMap;
    data['product_process_id'] = productProcessId;
    data['product_process_name'] = productProcessName;
    data['area_id'] = areaId;
    return data;
  }

  Diary.copy(Diary other)
      : id = other.id,
        userId = other.userId,
        action = other.action,
        name = other.name,
        seasonId = other.seasonId,
        seasonName = other.seasonName,
        farmName = other.farmName,
        farmId = other.farmId,
        productId = other.productId,
        productName = other.productName,
        cropName = other.cropName,
        cropId = other.cropId,
        amount = other.amount,
        amountUnitName = other.amountUnitName,
        amountUnitId = other.amountUnitId,
        area = other.area,
        areaUnitId = other.areaUnitId,
        areaUnitName = other.areaUnitName,
        yieldEstimate = other.yieldEstimate,
        yieldEstimateUnitName = other.yieldEstimateUnitName,
        yieldEstimateUnitId = other.yieldEstimateUnitId,
        yieldReal = other.yieldReal,
        yieldRealUnitName = other.yieldRealUnitName,
        yieldRealUnitId = other.yieldRealUnitId,
        harvesting = other.harvesting,
        description = other.description,
        endDate = other.endDate,
        startDate = other.startDate,
        status = other.status,
        statusName = other.statusName,
        areaName = other.areaName,
        areaCode = other.areaCode,
        farmerName = other.farmerName,
        farmerId = other.farmerId,
        farmCode = other.farmCode,
        googleMap = other.googleMap,
        productProcessId = other.productProcessId,
        productProcessName = other.productProcessName,
        areaId = other.areaId;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return DiaryTableCompanion(
      id: Value(id),
      action: Value(action),
      userId: Value(userId),
      name: Value(name),
      seasonId: Value(seasonId),
      seasonName: Value(seasonName),
      description: Value(description),
      farmId: Value(farmId),
      farmName: Value(farmName),
      productId: Value(productId),
      productName: Value(productName),
      cropName: Value(cropName),
      cropId: Value(cropId),
      amount: Value(amount),
      amountUnitId: Value(amountUnitId),
      amountUnitName: Value(amountUnitName),
      areaUnitId: Value(areaUnitId),
      areaUnitName: Value(areaUnitName),
      area: Value(area),
      yieldEstimateUnitId: Value(yieldEstimateUnitId),
      yieldEstimateUnitName: Value(yieldEstimateUnitName),
      yieldEstimate: Value(yieldEstimate),
      yieldRealUnitId: Value(yieldRealUnitId),
      yieldRealUnitName: Value(yieldRealUnitName),
      yieldReal: Value(yieldReal),
      harvesting: Value(harvesting),
      startDate: Value(startDate),
      endDate: Value(endDate),
      status: Value(status),
      statusName: Value(statusName),
      farmerId: Value(farmerId),
      farmerName: Value(farmerName),
      areaName: Value(areaName),
      areaCode: Value(areaCode),
      farmCode: Value(farmCode),
      googleMap:Value(googleMap),
      productProcessId: Value(productProcessId),
      productProcessName:Value(productProcessName),
      areaId: Value(areaId),
    ).toColumns(nullToAbsent);
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
