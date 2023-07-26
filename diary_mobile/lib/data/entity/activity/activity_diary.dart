import 'package:diary_mobile/data/local_data/diary_db.dart';
import 'package:diary_mobile/data/local_data/table/diary_table.dart';
import 'package:drift/drift.dart';

import '../image/image_entity.dart';
import '../item_default/item_default.dart';
import '../item_default/material_entity.dart';
import '../item_default/tool.dart';

class ActivityDiary implements Insertable<ActivityDiary>{
  int? id;
  int? seasonFarmId;
  String? seasonFarm;
  int? activityId;
  String? activity;
  String? actionTime;
  double? actionArea;
  int? actionAreaUnitId;
  String? actionAreaUnit;
  String? description;
  bool? isShow;
  // api chua co
  String? name;
  String? byName;
  String? startTime;
  String? endTime;
  int? status;
  //
  List<Tool> tool;
  List<MaterialEntity> material;
  List<ImageEntity> media;

  ActivityDiary({
    this.id,
    this.seasonFarmId,
    this.activityId,
    this.actionTime,
    this.actionArea,
    this.actionAreaUnitId,
    this.actionAreaUnit,
    this.description,
    this.activity,
    this.seasonFarm,
    this.isShow,

    this.name,
    this.byName,
    this.startTime,
    this.endTime,
    this.status,

    this.tool = const [],
    this.material = const [],
    this.media = const [],
  });

  factory ActivityDiary.fromJson(Map<String, dynamic> json) {
    return ActivityDiary(
      id: json['id'] ?? -1,
      seasonFarmId: json['season_farm_id'] ?? -1,
      seasonFarm: json['season_farm'] ?? "",
      activityId: json['activity_id'] ?? -1,
      actionTime: json['action_time'] ?? "",
      actionArea: json['action_area'] ?? 0,
      actionAreaUnitId: json['action_area_unit_id'] ?? -1,
      actionAreaUnit: json['action_area_unit'] ?? '',
      description: json['description'] ?? '',
      activity: json['activity'] ?? '',
      name: json['name'] ?? "",
      byName: json['by_name'] ?? "",
      startTime: json['start_time'] ?? "",
      endTime: json['end_time'] ?? "",
      status: json['status'] ?? -1,
      isShow: json['is_Shown'],

      tool: json['diary_tool_ids'] != null ? (json['diary_tool_ids'] as List<dynamic>).map((itemJson) => Tool.fromJson(itemJson)).toList() : [],
      material: json['diary_material_ids'] != null ? (json['diary_material_ids'] as List<dynamic>).map((itemJson) => MaterialEntity.fromJson(itemJson)).toList() : [],
      media: json['diary_media_ids'] != null ? (json['diary_media_ids'] as List<dynamic>).map((itemJson) => ImageEntity.fromJson(itemJson)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['season_farm_id'] = seasonFarmId;
    data['season_farm'] = seasonFarm;
    data['activity_id'] = activityId;
    data['action_time'] = actionTime;
    data['action_area'] = actionArea;
    data['action_area_unit_id'] = actionAreaUnitId;
    data['description'] = description;
    data['activity'] = activity;
    data['is_Shown'] = isShow;

    data['name'] = name;
    data['by_name'] = byName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;

    List<Map> listTool= [];
    for (int i = 0; i < tool.length; i++) {
      listTool.add(tool[i].toJson());
    }
    List<Map> listMaterial= [];
    for (int i = 0; i < material.length; i++) {
      listMaterial.add(material[i].toJson());
    }
    data['diary_tool_ids'] = listTool;
    data['diary_material_ids'] = listMaterial;
    data['diary_media_ids'] = media;
    return data;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ActivityDiaryTableCompanion(
        id: Value(id),
        seasonFarmId: Value(seasonFarmId),
        activityId: Value(activityId),
        actionTime: Value(actionTime),
        actionArea: Value(actionArea),
        actionAreaUnitId: Value(actionAreaUnitId),
        actionAreaUnit: Value(actionAreaUnit),
        description: Value(description),
        activity: Value(activity),
        name: Value(name),
        byName: Value(byName),
        startTime: Value(startTime),
        endTime: Value(endTime),
        status: Value(status))
        .toColumns(nullToAbsent);
  }
}
