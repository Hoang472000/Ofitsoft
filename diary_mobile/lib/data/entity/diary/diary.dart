import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:drift/drift.dart';

import '../image/image_entity.dart';
import '../item_default/item_default.dart';
import '../item_default/material_entity.dart';
import '../item_default/tool.dart';

class Diary implements Insertable<Diary> {
  //Thuoc tinh information detail diary
  int? id;
  String? name;
  int? seasonId;
  int? seasonFarmId;
  int? activityId;
  String? activity;
  int? farmId;
  String? farm;
  String? farmerName;
  int? cropId;
  String? crop;
  int? productId;
  String? productName;
  String? cropName;
  double? area;
  int? areaUnitId;
  String? areaUnit;
  double? amount;
  int? amountUnitId;
  String? amountUnit;
  double? yieldEstimate;
  int? yieldEstimateUnitId;
  String? yieldEstimateUnit;
  String? startDate;
  String? endDate;
  String? description;
  String? status;

  //Thuoc tinh information detail diary

  String? actionTime;
  double? actionArea;
  int? actionAreaUnitId;

  List<Tool> tool;
  List<MaterialEntity> material;
  List<ImageEntity> media;

  Diary({
    this.id,
    this.seasonId,
    this.seasonFarmId,
    this.activity,
    this.activityId,
    this.actionTime,
    this.actionArea,
    this.actionAreaUnitId,
    this.description,
    this.name,
    this.farmId,
    this.cropId,
    this.crop,
    this.productName,
    this.cropName,
    this.productId,
    this.area,
    this.areaUnit,
    this.areaUnitId,
    this.amount,
    this.amountUnitId,
    this.amountUnit,
    this.startDate,
    this.endDate,
    this.status,
    this.yieldEstimate,
    this.yieldEstimateUnitId,
    this.yieldEstimateUnit,
    this.farm,
    this.farmerName,
    this.tool = const [],
    this.material = const [],
    this.media = const [],
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'] ?? -1,
      seasonId: json['season_id'] ?? -1,
      seasonFarmId: json['season_farm_id'] ?? -1,
      activity: json['activity'] ?? '',
      activityId: json['activity_id'] ?? -1,
      actionTime: json['action_time'] ?? "",
      actionArea: json['action_area'] ?? 0,
      actionAreaUnitId: json['action_area_unit_id'] ?? -1,
      description: json['description'] ?? '',
      farmerName: json['farmer_name'] ?? '',
      farm: json['farm'] ?? '',
      farmId: json['farm_id'] ?? -1,
      name: json['name'] ?? "",
      crop: json['crop'] ?? "",
      productId: json['product_id'] ?? -1,
      productName: json['product_name'] ?? "",
      cropName: json['crop_name'] ?? "",
      startDate: json['start_date'] ?? "",
      endDate: json['end_date'] ?? "",
      status: json['status'] ?? "",
      areaUnitId: json['area_unit_id'] ?? -1,
      areaUnit: json['area_unit_name'] ?? '',
      area: json['area'] ?? -1,
      amountUnitId: json['amount_unit_id'] ?? -1,
      amountUnit: json['amount_unit'] ?? "",
      amount: json['amount'] ?? -1,
      yieldEstimateUnitId: json['yield_estimate_unit_id'] ?? -1,
      yieldEstimateUnit: json['yield_estimate_unit'] ?? '',
      yieldEstimate: json['yield_estimate'] ?? -1,
      tool: json['tool'] != null
          ? (json['tool'] as List<dynamic>)
              .map((itemJson) => Tool.fromJson(itemJson))
              .toList()
          : [],
      material: json['material'] != null
          ? (json['material'] as List<dynamic>)
              .map((itemJson) => MaterialEntity.fromJson(itemJson))
              .toList()
          : [],
      media: json['media'] != null
          ? (json['media'] as List<dynamic>)
              .map((itemJson) => ImageEntity.fromJson(itemJson))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['season_id'] = seasonId;
    data['season_farm_id'] = seasonFarmId;
    data['activity'] = activity;
    data['activity_id'] = activityId;
    data['action_time'] = actionTime;
    data['action_area'] = actionArea;
    data['action_area_unit_id'] = actionAreaUnitId;
    data['description'] = description;
    data['farmer_name'] = farmerName;
    data['farm'] = farm;
    data['farm_id'] = farmId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['crop_name'] = cropName;
    data['name'] = name;
    data['crop'] = crop;
    data['start_time'] = startDate;
    data['end_time'] = endDate;
    data['status'] = status;
    data['amount'] = amount;
    data['amount_unit'] = amountUnit;
    data['amount_unit_id'] = amountUnitId;
    data['area'] = area;
    data['area_unit_id'] = areaUnitId;
    data['area_unit_name'] = areaUnit;
    data['yield_estimate'] = yieldEstimate;
    data['yield_estimate_unit'] = yieldEstimateUnit;
    data['yield_estimate_unit_id'] = yieldEstimateUnitId;
    List<Map> listTool = [];
    for (int i = 0; i < tool.length; i++) {
      listTool.add(tool[i].toJson());
    }
    List<Map> listMaterial = [];
    for (int i = 0; i < material.length; i++) {
      listMaterial.add(material[i].toJson());
    }
    data['tool'] = listTool;
    data['material'] = listMaterial;
    data['media'] = media;
    return data;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return DiaryTableCompanion(
            id: Value(id),
            seasonId: Value(seasonId),
            seasonFarmId: Value(seasonFarmId),
            activity: Value(activity),
            activityId: Value(activityId),
            actionTime: Value(actionTime),
            actionArea: Value(actionArea),
            actionAreaUnitId: Value(actionAreaUnitId),
            description: Value(description),
            farmerName: Value(farmerName),
            productId: Value(productId),
            productName: Value(productName),
            cropName: Value(cropName),
            farm: Value(farm),
            name: Value(name),
            crop: Value(crop),
            startDate: Value(startDate),
            endDate: Value(endDate),
            status: Value(status),
            amount: Value(amount),
            amountUnitId: Value(amountUnitId),
            amountUnit: Value(amountUnit),
            areaUnitId: Value(areaUnitId),
            areaUnit: Value(areaUnit),
            area: Value(area),
            yieldEstimateUnitId: Value(yieldEstimateUnitId),
            yieldEstimateUnit: Value(yieldEstimateUnit),
            yieldEstimate: Value(yieldEstimate))
        .toColumns(nullToAbsent);
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
