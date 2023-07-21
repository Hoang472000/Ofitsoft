import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:drift/drift.dart';

import '../image/image_entity.dart';
import '../item_default/item_default.dart';
import '../item_default/material_entity.dart';
import '../item_default/tool.dart';

class Diary implements Insertable<Diary> {
  int? id;
  int? seasonFarmId;
  int? activityId;
  String? name;
  String? crop;
  String? user;
  String? startDate;
  String? endDate;
  double? area;
  String? areaUnitId;
  double? amount;
  String? amountUnitId;
  double? yieldEstimate;
  String? yieldEstimateUnitId;
  String? description;
  String? status;

  String? actionTime;
  double? actionArea;
  String? actionAreaUnitId;

  List<Tool> tool;
  List<MaterialEntity> material;
  List<ImageEntity> media;

  Diary(
      {this.id,
      this.seasonFarmId,
      this.activityId,
      this.actionTime,
      this.actionArea,
      this.actionAreaUnitId,
      this.description,
      this.name,
      this.user,
      this.startDate,
      this.endDate,
      this.status,
      this.crop,
      this.tool = const [],
      this.material = const [],
      this.media = const [],
      this.areaUnitId,
      this.area,
      this.amount,
      this.amountUnitId,
      this.yieldEstimate,
      this.yieldEstimateUnitId});

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'] ?? -1,
      seasonFarmId: json['season_farm_id'] ?? -1,
      activityId: json['activity_id'] ?? -1,
      actionTime: json['action_time'] ?? "",
      actionArea: json['action_area'] ?? 0,
      actionAreaUnitId: json['action_area_unit_id'] ?? '',
      description: json['description'] ?? '',
      user: json['user'] ?? '',
      name: json['name'] ?? "",
      crop: json['crop'] ?? "",
      startDate: json['start_date'] ?? "",
      endDate: json['end_date'] ?? "",
      status: json['status'] ?? -1,
      areaUnitId: json['area_unit_id'] ?? '',
      area: json['area'] ?? -1,
      amountUnitId: json['amount_unit_id'] ?? "",
      amount: json['amount'] ?? -1,
      yieldEstimateUnitId: json['yield_estimate_unit_id'] ?? '',
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
    data['season_farm_id'] = seasonFarmId;
    data['activity_id'] = activityId;
    data['action_time'] = actionTime;
    data['action_area'] = actionArea;
    data['action_area_unit_id'] = actionAreaUnitId;
    data['description'] = description;
    data['user'] = user;
    data['name'] = name;
    data['crop'] = crop;
    data['start_time'] = startDate;
    data['end_time'] = endDate;
    data['status'] = status;
    data['amount'] = amount;
    data['amount_unit_id'] = amountUnitId;
    data['area'] = area;
    data['area_unit_id'] = areaUnitId;
    data['yield_estimate'] = yieldEstimate;
    data['yield_estimate_unit_id'] = yieldEstimateUnitId;

    data['tool'] = tool;
    data['material'] = material;
    data['media'] = media;
    return data;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return DiaryTableCompanion(
            id: Value(id),
            seasonFarmId: Value(seasonFarmId),
            activityId: Value(activityId),
            actionTime: Value(actionTime),
            actionArea: Value(actionArea),
            actionAreaUnitId: Value(actionAreaUnitId),
            description: Value(description),
            user: Value(user),
            name: Value(name),
            crop: Value(crop),
            startDate: Value(startDate),
            endDate: Value(endDate),
            status: Value(status),
            amount: Value(amount),
            amountUnitId: Value(amountUnitId),
            areaUnitId: Value(actionAreaUnitId),
            area: Value(area),
            yieldEstimateUnitId: Value(yieldEstimateUnitId),
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
