import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:drift/drift.dart';

import '../item_default/item_default.dart';
import '../item_default/material_entity.dart';
import '../item_default/tool.dart';

class Diary implements Insertable<Diary>{
  int? id;
  int? seasonFarmId;
  int? activityId;
  String? nameActivity;
  String? actionTime;
  double? actionArea;
  String? actionAreaUnitId;
  String? description;
  // api chua co
  String? name;
  String? byName;
  String? startTime;
  String? endTime;
  int? status;
  //
  List<Tool> tool;
  List<MaterialEntity> material;
  List<Item> media;

  Diary({
     this.id,
     this.seasonFarmId,
     this.activityId,
     this.actionTime,
     this.actionArea,
     this.actionAreaUnitId,
     this.description,
this.nameActivity,
     this.name,
     this.byName,
     this.startTime,
     this.endTime,
     this.status,

    this.tool = const [],
    this.material = const [],
    this.media = const [],
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
        id: json['id'] ?? -1,
        seasonFarmId: json['season_farm_id'] ?? -1,
        activityId: json['activity_id'] ?? -1,
        actionTime: json['action_time'] ?? "",
        actionArea: json['action_area'] ?? 0,
        actionAreaUnitId: json['action_area_unit_id'] ?? '',
        description: json['description'] ?? '',
        nameActivity: json['name_activity'] ?? '',
        name: json['name'] ?? "",
        byName: json['by_name'] ?? "",
        startTime: json['start_time'] ?? "",
        endTime: json['end_time'] ?? "",
        status: json['status'] ?? -1,

        tool: json['tool'] != null ? (json['tool'] as List<dynamic>).map((itemJson) => Tool.fromJson(itemJson)).toList() : [],
        material: json['material'] != null ? (json['material'] as List<dynamic>).map((itemJson) => MaterialEntity.fromJson(itemJson)).toList() : [],
        media: json['media'] != null ? (json['media'] as List<dynamic>).map((itemJson) => Item.fromJson(itemJson)).toList() : [],
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
data['name_activity'] = nameActivity;
    data['name'] = name;
    data['by_name'] = byName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;

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
        nameActivity: Value(nameActivity),
        name: Value(name),
        byName: Value(byName),
        startTime: Value(startTime),
        endTime: Value(endTime),
        status: Value(status))
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